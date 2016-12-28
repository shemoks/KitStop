//
//  FilterTypeRouter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 20/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - FilterTypeRouter

final class FilterTypeRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - FilterTypeRouterInput

extension FilterTypeRouter: FilterTypeRouterInput {
    func closeTypeCategoryModule() {
        flowController.closeModule(animated: true)
    }
}
