//
//  UnderConstructionRouter.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import Perform
import UIKit

// MARK: - UnderConstructionRouter

final class UnderConstructionRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - UnderConstructionRouterInput

extension UnderConstructionRouter: UnderConstructionRouterInput {
    func logOut() {
        flowController.openModule(using: .openRoot) {
            guard let moduleInput = $0 as? RootModuleInput else { fatalError() }
            return nil
        }
    }
}

extension Segue {
    static var openRoot: Segue<RootViewController> {
        return .init(identifier: "transitionToRoot")
    }
}
