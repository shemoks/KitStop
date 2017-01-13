//
//  CustomListRouter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 12/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CustomListRouter

final class CustomListRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - CustomListRouterInput

extension CustomListRouter: CustomListRouterInput {

    func closeModule() {
        flowController.closeModule(animated: true)
    }

}
