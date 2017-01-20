//
//  KitFolioDetailedRouter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import Perform

// MARK: - KitFolioDetailedRouter

final class KitFolioDetailedRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - KitFolioDetailedRouterInput

extension KitFolioDetailedRouter: KitFolioDetailedRouterInput {
    
    func openChatModule() {
        flowController.openModule(using: .openUnderConstructionModule) {
            guard ($0 as? UnderConstructionModuleInput) != nil else {fatalError()}
            return nil
        }
    }
    
    func closeModule() {
        self.flowController.closeModule(animated: true)
    }

}

extension Segue {
    static var openUnderConstructionModule: Segue<UnderConstructionViewController> {
        return .init(identifier:"transitionToUnderConstruction")
    }
}
