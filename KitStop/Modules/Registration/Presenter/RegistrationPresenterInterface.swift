//
//  RegistrationPresenterInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 13/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - RegistrationViewOutput

protocol RegistrationViewOutput: class {

    func takePhoto()

}

// MARK: - RegistrationInteractorOutput

protocol RegistrationInteractorOutput: class {

}

// MARK: - RegistrationModuleInput

protocol RegistrationModuleInput: ModuleInput {

}

// MARK: - RegistrationModuleOutput

protocol RegistrationModuleOutput: ModuleOutput {

}
