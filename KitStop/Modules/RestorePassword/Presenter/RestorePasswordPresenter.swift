//
//  RestorePasswordPresenter.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - RestorePasswordPresenter

final class RestorePasswordPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: RestorePasswordViewInput!
    var interactor: RestorePasswordInteractorInput!
    var router: RestorePasswordRouterInput!

}

// MARK: - RestorePasswordViewOutput

extension RestorePasswordPresenter: RestorePasswordViewOutput {
    func handleSubmitTap(email: String) {
        interactor.restorePassword(email: email)
    }
    
    func handleEditing(isEmpty: Bool) {
        if isEmpty {
            view.changeSubmitStatus(status: false)
        } else {
            view.changeSubmitStatus(status: true)
        }
        
    }
    
    func dismissModule() {
        router.dismissModule()
    }
}

// MARK: - RestorePasswordInteractorOutput

extension RestorePasswordPresenter: RestorePasswordInteractorOutput {
    func showAlert(message: String, shouldTransition: Bool) {
        if shouldTransition {
            view.dismissAfterAlert(message: message)
        } else {
            view.showAlert(message: message)
        }
    }
}

// MARK: - RestorePasswordModuleInput

extension RestorePasswordPresenter: RestorePasswordModuleInput {

}
