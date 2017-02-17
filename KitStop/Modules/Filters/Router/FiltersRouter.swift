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

    func openMainModule() {
        flowController.openModule(using: .returnMain)  {
            guard let moduleInput = $0 as? MainModuleInput else { fatalError() }
            return nil
        }
    }

    func openTypeModule(types: [Category], filterTypeModuleOutput: FilterTypeModuleOutput) {
        flowController.openModule(using: .openFilterCategory) {
            guard let moduleInput = $0 as? FilterTypeModuleInput else { fatalError() }
            moduleInput.setCategories(categories: types)
            return filterTypeModuleOutput
        }
    }
    
    func returnToMainModule(filter: Bool, moduleOutput: FiltersModuleOutput) {
        moduleOutput.kitsWithFilters(filter: filter)
        self.closeModule()
    }
}

extension Segue {

    static var openFilterCategory: Segue<FilterTypeViewController> {
        return .init(identifier: "FilterCategories")
    }

    static var returnMain: Segue<MainViewController> {
        return .init(identifier: "unwind")
    }
    
}
