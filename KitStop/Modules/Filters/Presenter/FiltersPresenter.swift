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
    var price = Price(minValue: 0, maxValue: 1)

}

// MARK: - FiltersViewOutput

extension FiltersPresenter: FiltersViewOutput {

    func handleViewDidLoad(filter: Filter) {

        interactor.getBrands(currentFilter: filter)
        interactor.getTypes(currentFilter: filter)
        interactor.getPrice()

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

}

// MARK: - FiltersModuleInput

extension FiltersPresenter: FiltersModuleInput {

}
