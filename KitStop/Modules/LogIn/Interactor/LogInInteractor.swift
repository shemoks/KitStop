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
    fileprivate let dataManager: DataManagerProtocol
    // MARK: -
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    convenience init() {
        self.init(dataManager: DataManager())
    }

}

// MARK: - LogInInteractorInput

extension LogInInteractor: LogInInteractorInput {
    func fetchUserData(userDataModel: LogInUserModel) {
        dataManager.fetchUserInServer(email: userDataModel.login, password: userDataModel.password)
    }
}
