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

    // MARK: -

}

// MARK: - LogInInteractorInput

extension LogInInteractor: LogInInteractorInput {
    func fetchUserData(userDataModel: LogInUserModel) {
//        DataManager.sharedInstance.fetchUserInServer(email: userDataModel.login, password: userDataModel.password)
    }
}
