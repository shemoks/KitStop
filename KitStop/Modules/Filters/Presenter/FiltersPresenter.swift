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
    var currentCategory: Category?
 //   var filter = Filter(idCategory: 0, title: "", minPrice: 0, maxPrice: 100)
    var priceVisible: Bool = false

}

// MARK: - FiltersViewOutput

extension FiltersPresenter: FiltersViewOutput {

    func handleApplyTap(price: Price) {
        if self.currentCategory != nil {
        interactor.getProducts(category: self.currentCategory!, price: price, type: priceVisible)
        interactor.clearAll(types: self.types)
            view.reloadData()
            self.price = Price(minValue: 0, maxValue: 100)
            view.reloadPrice()
        }
    }

    func typesList() -> [Category] {
        return self.types
    }

    func priceList() -> PriceString {
        let priceString = PriceString(price: self.price, minValue: "$"+String(self.price.minValue), maxValue: "$"+String(self.price.maxValue))
        return priceString
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
        view.priceVisible(visible: self.priceVisible)
        interactor.getFilters()
        view.reloadData()
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
    
    func handleViewWillDisappear(kits: [Product]) {
        let mainModuleOutput = moduleOutput as! FiltersModuleOutput
        router.returnToMainModule(kits: kits, moduleOutput: mainModuleOutput)
    }

}

// MARK: - FiltersModuleInput

extension FiltersPresenter: FiltersModuleInput {

    func priceVisible(visible: Bool) {

        self.priceVisible = visible

    }

}

extension FiltersPresenter: FilterTypeModuleOutput {

    func currentCategory(categories: [Category], currentCategory: Category) {

        self.types = categories
        view.reloadData()
        self.currentCategory = currentCategory
        interactor.getPrice(category: currentCategory)
        view.reloadPrice()

    }
    
}


