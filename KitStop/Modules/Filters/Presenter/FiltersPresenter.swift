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
    var types = [Category]()
    var price = Price(minValue: 0, maxValue: 100)
    var filter = Filter(idCategory: 0, title: "", minPrice: 0, maxPrice: 100)
    var priceVisible: Bool = true

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

    func typesList() -> [Category] {
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
        view.reloadData()
        view.reloadPrice()

    }

    func handleTypeTap() {
        router.openTypeModule(types: self.types, filterTypeModuleOutput: self)
    }

    func handleViewDidLoad() {
        interactor.getFilters()
        view.reloadData()
        view.priceVisible(visible: self.priceVisible)
        view.reloadPrice()
    }

    func changePrice(price: Price) {
        self.price = price
    }

    func visible() -> Bool {
        return self.priceVisible
    }

}

// MARK: - FiltersInteractorOutput

extension FiltersPresenter: FiltersInteractorOutput {


    func setTypes(types: [Category]) {
        self.types = types
        view.reloadData()
    }

    func setPrice(price: Price) {
        self.price = price
        view.reloadPrice()
    }

    func showError(title: String, message: String) {
        view.showError(title: title, message: message)
    }

}

// MARK: - FiltersModuleInput

extension FiltersPresenter: FiltersModuleInput {

    func priceVisible(visible: Bool) {

        self.priceVisible = false

    }

}

extension FiltersPresenter: FilterTypeModuleOutput {

    func currentCategory(categories: [Category], currentCategory: Category) {

        self.types = categories
        view.reloadData()
        interactor.getPrice(category: currentCategory)
        view.reloadPrice()
//        self.filter = Filter(idCategory: category.number, title: category.title, minPrice: self.price.minValue, maxPrice: self.price.maxValue)

    }
    
}


