//
//  FiltersPresenterInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - FiltersViewOutput

protocol FiltersViewOutput: class {

    func handleViewDidLoad(filter: Filter)
    func typesList() -> [FilterItems]
    func brandsList() -> [FilterItems]
    func priceList() -> Price

}

// MARK: - FiltersInteractorOutput

protocol FiltersInteractorOutput: class {

    func setBrands(brands: [FilterItems])
    func setTypes(types: [FilterItems])
    func setPrice(price: Price)
    
}

// MARK: - FiltersModuleInput

protocol FiltersModuleInput: ModuleInput {

}

// MARK: - FiltersModuleOutput

protocol FiltersModuleOutput: ModuleOutput {

}
