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

}

// MARK: - RestorePasswordInteractorOutput

extension RestorePasswordPresenter: RestorePasswordInteractorOutput {

}

// MARK: - RestorePasswordModuleInput

extension RestorePasswordPresenter: RestorePasswordModuleInput {

}
