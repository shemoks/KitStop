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
}

// MARK: - LogInInteractorOutput

protocol LogInInteractorOutput: class {

}

// MARK: - LogInModuleInput

protocol LogInModuleInput: ModuleInput {

}

// MARK: - LogInModuleOutput

protocol LogInModuleOutput: ModuleOutput {

}
