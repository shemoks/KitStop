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
    var categories = [Category]()

}

// MARK: - FilterTypeViewOutput

extension FilterTypePresenter: FilterTypeViewOutput {

    func category(for indexPath: IndexPath) -> Category {

            return categories[indexPath.row]
    }

    func numberOfCategories() -> Int {
        return categories.count
    }

    func returnCategory (category: Category) {
        let filterTypeModuleOutput = moduleOutput as! FilterTypeModuleOutput
        self.categories = interactor.changeCategories(categories: self.categories, category: category)
        filterTypeModuleOutput.currentCategory(categories: categories, currentCategory: category)
        router.closeTypeCategoryModule()
    }

}

// MARK: - FilterTypeInteractorOutput

extension FilterTypePresenter: FilterTypeInteractorOutput {

}

// MARK: - FilterTypeModuleInput

extension FilterTypePresenter: FilterTypeModuleInput {

    func setCategories(categories: [Category]) {
        self.categories = categories
    }

}
