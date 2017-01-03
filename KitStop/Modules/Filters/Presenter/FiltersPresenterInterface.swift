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

    func handleApplyTap(price: Price)
    func typesList() -> [Category]
    func priceList() -> PriceString
    func handleCancelTap()
    func handleClearAllTap()
    func handleTypeTap()
    func handleViewDidLoad()
    func changePrice(price: Price)
    func visible() -> Bool

}

// MARK: - FiltersInteractorOutput

protocol FiltersInteractorOutput: class {

    func setTypes(types: [Category])
    func setPrice(price: Price)
    func showError(title: String, message: String)
    func handleViewWillDisappear(kits: [Product])
    func setCurrentCategory(category: Category?)
    
}

// MARK: - FiltersModuleInput

protocol FiltersModuleInput: ModuleInput {

    func priceVisible(visible: Bool)

}

// MARK: - FiltersModuleOutput

protocol FiltersModuleOutput: ModuleOutput {
    func kitsWithFilters(kits: [Product], filter: Bool)
}