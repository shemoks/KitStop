//
//  UnderConstructionPresenter.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - UnderConstructionPresenter

final class UnderConstructionPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: UnderConstructionViewInput!
    var interactor: UnderConstructionInteractorInput!
    var router: UnderConstructionRouterInput!

}

// MARK: - UnderConstructionViewOutput

extension UnderConstructionPresenter: UnderConstructionViewOutput {
    func logOut() {
        router.logOut()
    }
}

// MARK: - UnderConstructionInteractorOutput

extension UnderConstructionPresenter: UnderConstructionInteractorOutput {

}

// MARK: - UnderConstructionModuleInput

extension UnderConstructionPresenter: UnderConstructionModuleInput {
    func addLogOut() {
        view.addLogOut()
    }
}
