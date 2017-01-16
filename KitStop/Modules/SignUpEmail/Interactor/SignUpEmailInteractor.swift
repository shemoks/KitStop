//
//  SignUpEmailInteractor.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - SignUpEmailInteractor

final class SignUpEmailInteractor {
    
    // MARK: - VIPER stack
    
    weak var presenter: SignUpEmailInteractorOutput!
    
    fileprivate let service: SignUpServiceProtocol
    fileprivate let awsManager: AWS3UploadImageProtocol
    fileprivate let dataManager: LogInDataManagerProtocol
    // MARK: -
    
    init(service: SignUpServiceProtocol, awsManager: AWS3UploadImageProtocol, dataManager: LogInDataManagerProtocol) {
        self.service = service
        self.awsManager = awsManager
        self.dataManager = dataManager
    }
    
    convenience init() {
        self.init(service: SignUpService(), awsManager: AWS3UploadImageService(), dataManager: LogInDataManager())
    }
    
    
}

// MARK: - SignUpEmailInteractorInput

extension SignUpEmailInteractor: SignUpEmailInteractorInput {
    func addUser(user: SignUpUserModel) {
        if user.userImage == nil {
            addUser(result: nil, user: user)
        } else {
            awsManager.uploadImage(userImage: user.userImage, path: "UserPhoto",successBlock: {
                result in
                self.addUser(result: result!, user: user)
            })
        }
    }
    
    func addUser(result: String?, user: SignUpUserModel) {
        self.service.addNewUser(email: user.email, password: user.password, photoUrl: result == nil ? nil : result!, name: user.name, surname: user.surname, completionBlock: {
            result, error, json in
            LoadingIndicatorView.hide()
            if result {
                self.presenter.openMainModule()
                if let json = json {
                    self.dataManager.saveUserData(json: json)
                }
            } else {
                let errorMassage = CustomError(code: error!).description
                self.presenter.showAlert(title: "Error", massage: errorMassage)
            }
        })
    }
}
