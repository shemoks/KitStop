//
//  FiltersRouter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import Perform

// MARK: - FiltersRouter

final class FiltersRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - FiltersRouterInput

extension FiltersRouter: FiltersRouterInput {

    func closeModule() {
        flowController.closeModule(animated: true)
    }

    func openTypeModule(types: [Category], filterTypeModuleOutput: FilterTypeModuleOutput) {
        flowController.openModule(using: .openFilterCategory) {
            guard let moduleInput = $0 as? FilterTypeModuleInput else { fatalError() }
            moduleInput.setCategories(categories: types)
            return filterTypeModuleOutput
        }
    }
    
    func returnToMainModule(kits: [Product], moduleOutput: FiltersModuleOutput) {
        moduleOutput.kitsWithFilters(kits: kits)
        self.closeModule()
    }
}

extension Segue {

    static var openFilterCategory: Segue<FilterTypeViewController> {
        return .init(identifier: "FilterCategories")
    }
    
}
