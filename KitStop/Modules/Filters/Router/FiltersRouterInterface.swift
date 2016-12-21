//
//  FiltersRouterInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - FiltersRouterInput

protocol FiltersRouterInput: class {

    func closeModule()
    func openBrandModule(brands: [FilterItems], filterBrandModuleOutput: FilterBrandModuleOutput)
    func openTypeModule(types: [FilterItems])

}
