//
//  LogInPresenterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 08/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - LogInViewOutput

protocol LogInViewOutput: class {
    func handleUserData(userData: Dictionary<String, String>)
    func openForgetPasswordModule()
    func clearTextFields()
}

// MARK: - LogInInteractorOutput

protocol LogInInteractorOutput: class {
    func openMainModule()
    func showAlert(title: String, massage: String)
}

// MARK: - LogInModuleInput

protocol LogInModuleInput: ModuleInput {

}

// MARK: - LogInModuleOutput

protocol LogInModuleOutput: ModuleOutput {

}
