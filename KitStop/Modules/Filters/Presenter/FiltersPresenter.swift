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
    var brands = [FilterItems]()
    var price = Price(minValue: 0, maxValue: 100)
    var brandsInCategory = [FilterItems]()

}

// MARK: - FiltersViewOutput

extension FiltersPresenter: FiltersViewOutput {

    func handleApplyTap(price: Price) {
        let filter = Filter()
        filter.brandFilter = self.brands
        filter.typeFilter = self.types
        self.price = price
        filter.priceFilter = price
        // interactor.getProducts(filter: Filter)
    }

    func typesList() -> [FilterItems] {
        return self.types
    }

    func brandsList() -> [FilterItems] {
        return self.brands
    }

    func priceList() -> Price {
        return self.price
    }

    func handleCancelTap() {
        router.closeModule()
    }

    func handleClearAllTap() {
        interactor.clearAll(types: self.types, brands: self.brands)
    }

    func handleBrandTap() {
        interactor.getBrandsInCategory(category: "Cameras")
       // interactor.getBrandsInCategory(category: (self.types.first?.title)!)
        router.openBrandModule(brands: self.brandsInCategory, filterBrandModuleOutput: self)
    }

    func handleTypeTap() {
        router.openTypeModule(types: self.types)
    }

    func handleViewDidLoad() {
        interactor.getFilters()
    }

    func isTypesExist() -> Bool {
        return interactor.isTypesExist(types: self.types)
    }

    func changeBrands(brands: [FilterItems]) {
        self.brands = brands
    }

    func changePrice(price: Price) {
        self.price = price
    }

}

// MARK: - FiltersInteractorOutput

extension FiltersPresenter: FiltersInteractorOutput {

    func setBrands(brands: [FilterItems]) {
        self.brands = brands
    }

    func setTypes(types: [FilterItems]) {
        self.types = types
    }

    func setPrice(price: Price) {
        self.price = price
    }

    func showError(title: String, message: String) {
        view.showError(title: title, message: message)
    }

    func setBrandsInCategory(brands: [FilterItems]) {
        self.brandsInCategory = brands
    }

}

// MARK: - FiltersModuleInput

extension FiltersPresenter: FiltersModuleInput {

}

extension FiltersPresenter: FilterBrandModuleOutput {

    func selectedBrands(brands: [FilterItems]) {
        view.setBrandsInCategory(brands: brands)
    }
}
