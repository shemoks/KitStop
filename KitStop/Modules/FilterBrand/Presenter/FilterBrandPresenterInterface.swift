//
//  FilterBrandPresenterInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 20/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - FilterBrandViewOutput

protocol FilterBrandViewOutput: class {

    func brandList() -> [FilterItems]
    func selectedBrands(brands: [FilterItems])
  //  func handleViewDidLoad(brands: [FilterItems])
    
}

// MARK: - FilterBrandInteractorOutput

protocol FilterBrandInteractorOutput: class {

}

// MARK: - FilterBrandModuleInput

protocol FilterBrandModuleInput: ModuleInput {

    func setBrands(brands: [FilterItems])

}

// MARK: - FilterBrandModuleOutput

protocol FilterBrandModuleOutput: ModuleOutput {

    func selectedBrands(brands: [FilterItems])

}
