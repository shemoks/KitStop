//
//  LogInInteractor.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 08/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - LogInInteractor

final class LogInInteractor {
    // MARK: - VIPER stack

    weak var presenter: LogInInteractorOutput!
    fileprivate let service: LogInServiceProtocol
    fileprivate let dataManager: LogInDataManagerProtocol
    // MARK: -
    
    init(service: LogInServiceProtocol, dataManager: LogInDataManagerProtocol) {
        self.service = service
        self.dataManager = dataManager
    }
    
    convenience init() {
        self.init(service: LogInService(), dataManager: LogInDataManager())
    }

}

// MARK: - LogInInteractorInput

extension LogInInteractor: LogInInteractorInput {
    func fetchUserData(userDataModel: LogInUserModel) {
        service.fetchUser(email: userDataModel.login, password: userDataModel.password, result: {
            res, error , json in
            if res && (error == nil) {
                self.dataManager.saveUserData(json: json!)
                self.presenter.openMainModule()
            } else {
                let errorMessage = CustomError(code: error!).description
                self.presenter.showAlert(title: "Error", massage: errorMessage)
            }
        })
    }
}
