//
//  MainSearchRouter.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - MainSearchRouter

final class MainSearchRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - MainSearchRouterInput

extension MainSearchRouter: MainSearchRouterInput {
    func closeModule() {
        flowController.closeModule(animated: true)
    }
}
