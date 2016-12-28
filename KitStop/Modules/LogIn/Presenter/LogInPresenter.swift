//
//  LogInPresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 08/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - LogInPresenter

final class LogInPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: LogInViewInput!
    var interactor: LogInInteractorInput!
    var router: LogInRouterInput!

}

// MARK: - LogInViewOutput

extension LogInPresenter: LogInViewOutput {

    func handleUserData(userData: Dictionary<String, String>) {
        let userModel = LogInUserModel.init(login: userData["login"]!, password: userData["password"]!)
        interactor.fetchUserData(userDataModel: userModel)
    }
    
    func openForgetPasswordModule() {
        router.openForgotPasswordModule()
    }
    
}

// MARK: - LogInInteractorOutput

extension LogInPresenter: LogInInteractorOutput {
    
    func openMainModule() {
        router.openMainModule()
    }
    
    func showAlert(title: String, massage: String) {
        view.showAlert(title: title, massage: massage)
    }
    
    func clearTextFields() {
        view.clearTextFields()
    }
}

// MARK: - LogInModuleInput

extension LogInPresenter: LogInModuleInput {

}
