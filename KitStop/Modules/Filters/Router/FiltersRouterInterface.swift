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
    func openTypeModule(types: [Category], filterTypeModuleOutput: FilterTypeModuleOutput)
    func returnToMainModule(kits: [Product], filter: Bool, moduleOutput: FiltersModuleOutput)
}