//
//  FilterBrandPresenter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 20/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - FilterBrandPresenter

final class FilterBrandPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: FilterBrandViewInput!
    var interactor: FilterBrandInteractorInput!
    var router: FilterBrandRouterInput!

}

// MARK: - FilterBrandViewOutput

extension FilterBrandPresenter: FilterBrandViewOutput {

}

// MARK: - FilterBrandInteractorOutput

extension FilterBrandPresenter: FilterBrandInteractorOutput {

}

// MARK: - FilterBrandModuleInput

extension FilterBrandPresenter: FilterBrandModuleInput {

}
