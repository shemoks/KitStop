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
            res in
            if res {
                self.presenter.openMainModule()
            } else {
                self.presenter.showAlert(title: "Error", massage: "Internet isn`t connecting")
            }
        })
    }
}
