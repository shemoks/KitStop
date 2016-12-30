//
//  SignUpPresenter.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 08/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SignUpPresenter

final class SignUpPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: SignUpViewInput!
    var interactor: SignUpInteractorInput!
    var router: SignUpRouterInput!

}

// MARK: - SignUpViewOutput

extension SignUpPresenter: SignUpViewOutput {

    func emailLogin() {
        router.openLoginModule()
    }

    func signUp() {
        router.openRegistrationModule()
    }
    
    func handleFacebookLoginTap() {
         interactor.signUpWithFacebook()
    }

}

// MARK: - SignUpInteractorOutput

extension SignUpPresenter: SignUpInteractorOutput {
    func openMainModule() {
        router.openMainModule()
    }
}

// MARK: - SignUpModuleInput

extension SignUpPresenter: SignUpModuleInput {

}
