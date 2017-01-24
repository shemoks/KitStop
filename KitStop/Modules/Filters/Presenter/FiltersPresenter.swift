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
    var price = Price(minValue: 0, maxValue: 1000000000)
    var currentCategory: Category?
    var priceVisible: Bool = false
    var activeClearAll: Bool = false
    
}

// MARK: - FiltersViewOutput

extension FiltersPresenter: FiltersViewOutput {
    
    func handleApplyTap(price: Price) {
        if self.currentCategory != nil {
            interactor.getProducts(category: self.currentCategory!, price: price, type: priceVisible)
        } else {
            self.handleViewWillDisappear(kits: [])
            router.closeModule()
        }
    }
    
    func typesList() -> [Category] {
        return self.types
    }
    
    func priceList() -> PriceString {
        if self.price.maxValue != 2000 {
        let priceString = PriceString(price: self.price, minValue: "$"+String(self.price.minValue), maxValue: "$"+String(self.price.maxValue))
             return priceString
        } else {
            let priceString = PriceString(price: self.price, minValue: "$"+String(self.price.minValue), maxValue: "$"+String(self.price.maxValue) + "+") 
            return priceString
        }
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
        view.activeClearAll(isActive: self.activeClearAll)
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
        if currentCategory != nil {
            let mainModuleOutput = moduleOutput as! FiltersModuleOutput
            router.returnToMainModule(kits: kits, filter: true, moduleOutput: mainModuleOutput)
        } else {
            let mainModuleOutput = moduleOutput as! FiltersModuleOutput
            router.returnToMainModule(kits: [], filter: false,  moduleOutput: mainModuleOutput)
        }
    }
    
    func setCurrentCategory(category: Category?) {
        self.currentCategory = category
        self.activeClearAll = true
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
        view.activeClearAll(isActive: true)
        self.types = categories
        view.reloadData()
        self.setCurrentCategory(category: currentCategory)
        interactor.getPrice(category: currentCategory, categories: categories)
        view.reloadPrice()
    }
    
}


