//
//  FiltersPresenter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - FiltersPresenter

final class FiltersPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: FiltersViewInput!
    var interactor: FiltersInteractorInput!
    var router: FiltersRouterInput!
    var types = [FilterItems]()
    var price = Price(minValue: 0, maxValue: 100)

}

// MARK: - FiltersViewOutput

extension FiltersPresenter: FiltersViewOutput {

    func handleApplyTap(price: Price) {
//        let filter = Filter()
//        filter.typeFilter = self.types
//        self.price = price
//        filter.priceFilter = price
        // interactor.getProducts(filter: Filter)
    }

    func typesList() -> [FilterItems] {
        return self.types
    }

    func priceList() -> Price {
        return self.price
    }

    func handleCancelTap() {
        router.closeModule()
    }

    func handleClearAllTap() {
        interactor.clearAll(types: self.types)
    }


    func handleTypeTap() {
        router.openTypeModule(types: self.types, filterTypeModuleOutput: self)
    }

    func handleViewDidLoad() {
        interactor.getFilters()
    }

    func changePrice(price: Price) {
        self.price = price
    }

}

// MARK: - FiltersInteractorOutput

extension FiltersPresenter: FiltersInteractorOutput {


    func setTypes(types: [FilterItems]) {
        self.types = types
    }

    func setPrice(price: Price) {
        self.price = price
    }

    func showError(title: String, message: String) {
        view.showError(title: title, message: message)
    }


}

// MARK: - FiltersModuleInput

extension FiltersPresenter: FiltersModuleInput {

}

extension FiltersPresenter: FilterTypeModuleOutput {

    func currentCategory(category: FilterItems) {

    }

}


