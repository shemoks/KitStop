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
    var filter = FilterModel()
    var currentFilter = CurrentFilter()
    var sliderVisible: Bool = true
    
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
    
    func typesList() -> String {
        return self.currentFilter.title
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
        //view.activeClearAll(isActive: self.activeClearAll)
        interactor.getFilters() { _ in
            self.interactor.getCurrentFilter(type: self.types, section: self.priceVisible) { result in
                self.visibleComponents()

            }
        }
    }
    
    func changePrice(price: Price) {
        self.price = price
    }
    
    func visible() -> Bool {
        return self.priceVisible
    }

    func visibleComponents() {
        if self.sliderVisible {
            self.view.isVisiblePrice(result: self.sliderVisible)
            self.view.reloadData()
            self.view.reloadPrice()
        } else {
            self.view.isVisiblePrice(result: self.sliderVisible)
            self.view.reloadData()
            self.view.reloadPrice()
        }
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
        self.currentFilter.maxValue = self.price.maxValue
        self.currentFilter.minValue = self.price.minValue
        self.visibleComponents()
        view.reloadData()
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
        if category != nil {
        self.currentCategory = category
        self.activeClearAll = true
       // self.priceVisible = true
        } else {
            //
        }
    }

    func setFilter(filter: FilterModel) {
        self.filter = filter
        let category = Category()
        category.number = filter.number
        category.isSelected = true
        category.title = filter.title
        self.currentCategory = category
        self.currentFilter.maxValue = filter.maxValue
        self.currentFilter.minValue = filter.minValue
        self.currentFilter.number = filter.number
        self.currentFilter.section = filter.section
        self.currentFilter.title = filter.title
        if currentFilter.title == "All categories" {
            self.sliderVisible = false
        } else {
            self.sliderVisible = true
        }
    }

    func isVisiblePriceSlider(isVisible: Bool) {
        self.sliderVisible = isVisible
    }


}

// MARK: - FiltersModuleInput

extension FiltersPresenter: FiltersModuleInput {
    
    func priceVisible(visible: Bool) {
        
        self.priceVisible = visible
        
    }
    
}

extension FiltersPresenter: FilterTypeModuleOutput {
    
    func currentCategory(currentCategory: Category) {
        view.activeClearAll(isActive: true)
      //  self.types = categories
        self.currentFilter.title = currentCategory.title
        self.currentFilter.number = currentCategory.number
        self.setCurrentCategory(category: currentCategory)
        interactor.getPrice(category: currentCategory)
    }
    
}


