//
//  FiltersRouter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

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

    func openBrandModule() {
        
    }

    func openTypeModule() {

    }

}
