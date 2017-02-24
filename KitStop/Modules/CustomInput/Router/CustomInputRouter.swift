//
//  CustomInputRouter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CustomInputRouter

final class CustomInputRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - CustomInputRouterInput

extension CustomInputRouter: CustomInputRouterInput {

    func closeModule(data: Other, moduleOutput: CustomInputModuleOutput) {
        moduleOutput.setOther(data: data)
        flowController.closeModule(animated: false)
    }
    
}
