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
    var filter: FilterModel?
    var currentFilter: CurrentFilter?
    var sliderVisible: Bool = true

}

// MARK: - FiltersViewOutput

extension FiltersPresenter: FiltersViewOutput {

    func handleApplyTap(price: Price) {
        if self.currentFilter != nil && sliderVisible || self.currentFilter != nil && priceVisible {
            if self.filter != nil {
                interactor.updateFilter(filter: self.filter!, currentFilter: self.currentFilter!)
                self.handleViewWillDisappear(filter: true)
                router.closeModule()
            } else {
                let filter = FilterModel()
                filter.section = (self.currentFilter?.section)!
                filter.maxValue = (self.currentFilter?.maxValue)!
                filter.minValue = (self.currentFilter?.minValue)!
                filter.number = (self.currentFilter?.number)!
                filter.title = (self.currentFilter?.title)!
                interactor.writeFilter(filter: filter)
                self.handleViewWillDisappear(filter: true)
                router.closeModule()
            }
        } else {
            self.handleViewWillDisappear(filter: false)
            router.closeModule()
        }
    }

    func typesList() -> CurrentFilter? {
        return self.currentFilter
    }

    func priceList() -> PriceString {
        var priceString = PriceString(price: self.price, minValue: "$"+String(self.price.minValue), maxValue: "$"+String(self.price.maxValue))
        if currentFilter != nil && self.currentFilter!.maxValue < 2000 {
            priceString = PriceString(price: self.price, minValue: "$"+String(self.currentFilter!.minValue), maxValue: "$"+String(self.currentFilter!.maxValue))
        }
        if currentFilter != nil && self.currentFilter!.maxValue == 2000 {
            priceString = PriceString(price: self.price, minValue: "$"+String(self.currentFilter!.minValue), maxValue: "$"+String(self.currentFilter!.maxValue) + "+")
        }


        return priceString
    }

    func handleCancelTap() {
        router.closeModule()
    }

    func handleClearAllTap() {
        if self.currentFilter != nil && self.filter != nil {
            interactor.clearAll(filter: self.filter!)
            self.currentFilter = nil
            self.filter = nil
            view.activeClearAll(isActive: false)
            self.sliderVisible = false
            view.reloadPrice()
            view.reloadData()
        }
    }

    func handleTypeTap() {
        interactor.getFilters()
    }

    func handleViewDidLoad() {
        view.priceVisible(visible: self.priceVisible)
        if currentFilter != nil {
            view.activeClearAll(isActive: true)
        } else {
            view.activeClearAll(isActive: false)
        }
        view.reloadData()
        view.reloadPrice()
    }

    func changePrice(price: Price) {
        self.price = price
        self.currentFilter?.maxValue = self.price.maxValue
        self.currentFilter?.minValue = self.price.minValue
    }

    func visible() -> Bool {
        return self.priceVisible
    }

    func isVisiblePriceSlider() -> Bool {
        return self.sliderVisible
    }

}

// MARK: - FiltersInteractorOutput

extension FiltersPresenter: FiltersInteractorOutput {


    func setTypes(types: [Category]) {
        self.types = types
        LoadingIndicatorView.hide()
        router.openTypeModule(types: self.types, filterTypeModuleOutput: self)
    }

    func setPrice(price: Price) {
        self.price = price
        self.currentFilter?.maxValue = self.price.maxValue
        self.currentFilter?.minValue = self.price.minValue

    }

    func showError(title: String, message: String) {
        view.showError(title: title, message: message)
    }

    func handleViewWillDisappear(filter: Bool) {
        let mainModuleOutput = moduleOutput as! FiltersModuleOutput
        router.returnToMainModule(filter: filter, moduleOutput: mainModuleOutput)
    }

    func setFilter(filter: FilterModel?) {
        if filter != nil {
            self.filter = filter
            let newCurrentFilter = CurrentFilter()
            newCurrentFilter.maxValue = filter!.maxValue
            newCurrentFilter.minValue = filter!.minValue
            newCurrentFilter.number = filter!.number
            newCurrentFilter.section = filter!.section
            newCurrentFilter.title = filter!.title
            self.currentFilter = newCurrentFilter
            self.price = Price(minValue: filter!.minValue, maxValue: filter!.maxValue)
            self.sliderVisible = true
            view.activeClearAll(isActive: true)
        } else {
            self.sliderVisible = false
            view.reloadData()
        }
    }

    func isVisibleSlider(isVisible: Bool) {
        self.sliderVisible = isVisible
        view.reloadPrice()
    }

}

// MARK: - FiltersModuleInput

extension FiltersPresenter: FiltersModuleInput {

    func priceVisible(visible: Bool) {
        self.priceVisible = visible
        interactor.getCurrentFilter(section: visible)
    }
}

extension FiltersPresenter: FilterTypeModuleOutput {

    func currentCategory(currentCategory: Category) {
        if currentFilter == nil {
            let filter = CurrentFilter()
            filter.title = currentCategory.title
            filter.number = currentCategory.number
            filter.section = self.priceVisible
            self.currentFilter = filter
        } else {
            currentFilter?.number = currentCategory.number
            currentFilter?.title = currentCategory.title
        }
        if !self.priceVisible {
            interactor.getPrice(category: currentCategory) { _ in
                self.view.reloadData()
                self.view.reloadPrice()
            }
        } else {
            self.view.reloadData()
        }
        
    }
}



