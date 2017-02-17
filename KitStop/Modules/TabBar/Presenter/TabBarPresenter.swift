//
//  TabBarPresenter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 14/02/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - TabBarPresenter

final class TabBarPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: TabBarViewInput!
    var interactor: TabBarInteractorInput!
    var router: TabBarRouterInput!

}

// MARK: - TabBarViewOutput

extension TabBarPresenter: TabBarViewOutput {

}

// MARK: - TabBarInteractorOutput

extension TabBarPresenter: TabBarInteractorOutput {

}

// MARK: - TabBarModuleInput

extension TabBarPresenter: TabBarModuleInput {

}
