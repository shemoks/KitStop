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
    fileprivate let dataManager: LogInServiceProtocol
    // MARK: -
    
    init(dataManager: LogInServiceProtocol) {
        self.dataManager = dataManager
    }
    
    convenience init() {
        self.init(dataManager: LogInService())
    }

}

// MARK: - LogInInteractorInput

extension LogInInteractor: LogInInteractorInput {
    func fetchUserData(userDataModel: LogInUserModel) {
        dataManager.fetchUser(email: userDataModel.login, password: userDataModel.password, result: {
            res, error in
            if res && error == nil {
                self.presenter.openMainModule()
            } else {
                let errorMassage = CustomError(code: error!).description
                self.presenter.showAlert(title: "Error", massage: errorMassage)
            }
        })
    }
}
