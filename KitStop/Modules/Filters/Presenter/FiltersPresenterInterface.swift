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
    func typesList() -> [FilterItems]
    func priceList() -> Price
    func handleCancelTap()
    func handleClearAllTap()
    func handleTypeTap()
    func handleViewDidLoad()
    func changePrice(price: Price)

}

// MARK: - FiltersInteractorOutput

protocol FiltersInteractorOutput: class {

    func setTypes(types: [FilterItems])
    func setPrice(price: Price)
    func showError(title: String, message: String)
    
}

// MARK: - FiltersModuleInput

protocol FiltersModuleInput: ModuleInput {

}

// MARK: - FiltersModuleOutput

protocol FiltersModuleOutput: ModuleOutput {

}
