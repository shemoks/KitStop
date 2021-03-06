//
//  SignUpPresenterInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 08/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SignUpViewOutput

protocol SignUpViewOutput: class {

    func emailLogin()
    func signUp()
    func handleFacebookLoginTap()
    func showButton()

}

// MARK: - SignUpInteractorOutput

protocol SignUpInteractorOutput: class {
    func openMainModule()
}

// MARK: - SignUpModuleInput

protocol SignUpModuleInput: ModuleInput {

}

// MARK: - SignUpModuleOutput

protocol SignUpModuleOutput: ModuleOutput {

}
