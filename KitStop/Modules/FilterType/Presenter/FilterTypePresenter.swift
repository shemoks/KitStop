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
    var categories = [FilterItems]()

}

// MARK: - FilterTypeViewOutput

extension FilterTypePresenter: FilterTypeViewOutput {

    func categoryList() -> [FilterItems] {
        return self.categories
    }

}

// MARK: - FilterTypeInteractorOutput

extension FilterTypePresenter: FilterTypeInteractorOutput {

}

// MARK: - FilterTypeModuleInput

extension FilterTypePresenter: FilterTypeModuleInput {

    func setCategories(categories: [FilterItems]) {
        self.categories = categories
    }

}
