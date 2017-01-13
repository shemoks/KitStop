//
//  CustomInputPresenter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CustomInputPresenter

final class CustomInputPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: CustomInputViewInput!
    var interactor: CustomInputInteractorInput!
    var router: CustomInputRouterInput!

}

// MARK: - CustomInputViewOutput

extension CustomInputPresenter: CustomInputViewOutput {

}

// MARK: - CustomInputInteractorOutput

extension CustomInputPresenter: CustomInputInteractorOutput {

}

// MARK: - CustomInputModuleInput

extension CustomInputPresenter: CustomInputModuleInput {

}
