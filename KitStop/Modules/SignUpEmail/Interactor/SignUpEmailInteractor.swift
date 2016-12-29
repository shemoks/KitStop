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

    fileprivate let dataManager: SignUpServiceProtocol
    fileprivate let awsManager: AWS3UploadImageProtocol
    // MARK: -
    
    init(dataManager: SignUpServiceProtocol, awsManager: AWS3UploadImageProtocol) {
        self.dataManager = dataManager
        self.awsManager = awsManager
    }
    
    convenience init() {
        self.init(dataManager: SignUpService(), awsManager: AWS3UploadImageService())
    }


}

// MARK: - SignUpEmailInteractorInput

extension SignUpEmailInteractor: SignUpEmailInteractorInput {
    func addUser(user: SignUpUserModel) {
        awsManager.uploadImage(userImage: user.userImage, successBlock: {
            result in
            self.dataManager.addNewUser(email: user.email, password: user.password, photoUrl: result!, completionBlock: {
                result in
                if result {
                    self.presenter.openMainModule()
                }
            })
        })
    }
}
