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

    func openBrandModule(brands: [FilterItems], filterBrandModuleOutput: FilterBrandModuleOutput) {
        flowController.openModule(using: .openSecond) {
            guard let moduleInput = $0 as? FilterBrandModuleInput else { fatalError() }
            moduleInput.setBrands(brands: brands)
            return filterBrandModuleOutput
        }
    }

    func openTypeModule(types: [FilterItems]) {

    }

}

extension Segue {

    static var openSecond: Segue<FilterBrandViewController> {
        return .init(identifier: "FilterBrandViewController")
    }
}
