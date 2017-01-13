//
//  CreateKitSavePresenter.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CreateKitSavePresenter

final class CreateKitSavePresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: CreateKitSaveViewInput!
    var interactor: CreateKitSaveInteractorInput!
    var router: CreateKitSaveRouterInput!

}

// MARK: - CreateKitSaveViewOutput

extension CreateKitSavePresenter: CreateKitSaveViewOutput {

}

// MARK: - CreateKitSaveInteractorOutput

extension CreateKitSavePresenter: CreateKitSaveInteractorOutput {

}

// MARK: - CreateKitSaveModuleInput

extension CreateKitSavePresenter: CreateKitSaveModuleInput {

}
