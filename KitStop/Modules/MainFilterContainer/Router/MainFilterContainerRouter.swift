//
//  MainFilterContainerRouter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import UIKit
import Perform

// MARK: - MainFilterContainerRouter

final class MainFilterContainerRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - MainFilterContainerRouterInput

extension MainFilterContainerRouter: MainFilterContainerRouterInput {
    
    func openFilterModule(filterModuleOutput: FiltersModuleOutput) {
        flowController.openModule(using: .openFilterModule) {
            guard ($0 as? FiltersModuleInput) != nil else { fatalError() }
            return filterModuleOutput
        }
    }
}

extension Segue {
    
    static var openFilterModule: Segue<FiltersViewController> {
        return .init(identifier: "transitionToFilter")
    }
}
