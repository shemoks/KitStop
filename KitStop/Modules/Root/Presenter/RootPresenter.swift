//
//  RootPresenter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 09/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - RootPresenter

final class RootPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: RootViewInput!
    var interactor: RootInteractorInput!
    var router: RootRouterInput!

}

// MARK: - RootViewOutput

extension RootPresenter: RootViewOutput {
    func handleViewDidload() {
        interactor.verifyAutorization()
    }
}

// MARK: - RootInteractorOutput

extension RootPresenter: RootInteractorOutput {
    func changeModuleSignUp() {
        router.changeModuleSignUp()
    }
    func changeModuleMain() {
        router.changeModuleMain()
    }
}

// MARK: - RootModuleInput

extension RootPresenter: RootModuleInput {

}
