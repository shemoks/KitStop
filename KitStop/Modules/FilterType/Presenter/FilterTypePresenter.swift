//
//  FilterTypePresenter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 20/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - FilterTypePresenter

final class FilterTypePresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: FilterTypeViewInput!
    var interactor: FilterTypeInteractorInput!
    var router: FilterTypeRouterInput!

}

// MARK: - FilterTypeViewOutput

extension FilterTypePresenter: FilterTypeViewOutput {

}

// MARK: - FilterTypeInteractorOutput

extension FilterTypePresenter: FilterTypeInteractorOutput {

}

// MARK: - FilterTypeModuleInput

extension FilterTypePresenter: FilterTypeModuleInput {

}
