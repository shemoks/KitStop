//
//  RegistrationPresenter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 13/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - RegistrationPresenter

final class RegistrationPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: RegistrationViewInput!
    var interactor: RegistrationInteractorInput!
    var router: RegistrationRouterInput!

}

// MARK: - RegistrationViewOutput

extension RegistrationPresenter: RegistrationViewOutput {

}

// MARK: - RegistrationInteractorOutput

extension RegistrationPresenter: RegistrationInteractorOutput {

}

// MARK: - RegistrationModuleInput

extension RegistrationPresenter: RegistrationModuleInput {

}
