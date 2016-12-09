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

}

// MARK: - SignUpInteractorOutput

protocol SignUpInteractorOutput: class {

}

// MARK: - SignUpModuleInput

protocol SignUpModuleInput: ModuleInput {

}

// MARK: - SignUpModuleOutput

protocol SignUpModuleOutput: ModuleOutput {

}
