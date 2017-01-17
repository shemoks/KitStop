//
//  CustomListRouter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 12/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import Perform

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

    func openCustomInputModule(data: Other, customInputModuleOutput: CustomInputModuleOutput) {
        flowController.openModule(using: .openOther) {
            guard let moduleInput = $0 as? CustomInputModuleInput else { fatalError() }
            moduleInput.setInput(data: data)
            return customInputModuleOutput
        }
    }
}

extension Segue {

    static var openOther: Segue<CustomInputViewController> {
        return .init(identifier: "TrunsitionToCustomInput")
    }

}



