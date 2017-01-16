//
//  BottomBarPresenter.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - BottomBarPresenter

final class BottomBarPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: BottomBarViewInput!
    var interactor: BottomBarInteractorInput!
    var router: BottomBarRouterInput!

}

// MARK: - BottomBarViewOutput

extension BottomBarPresenter: BottomBarViewOutput {

}

// MARK: - BottomBarInteractorOutput

extension BottomBarPresenter: BottomBarInteractorOutput {

}

// MARK: - BottomBarModuleInput

extension BottomBarPresenter: BottomBarModuleInput {

}
