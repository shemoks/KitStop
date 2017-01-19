//
//  KitsDetailedRouter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 18/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import Perform

// MARK: - KitsDetailedRouter

final class KitsDetailedRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - KitsDetailedRouterInput

extension KitsDetailedRouter: KitsDetailedRouterInput {

    func openModule(identifier: Int) {
        switch identifier {
            //            case 0:
            //                print("Activity")
            //            case 1:
            //                print("Conv")
            //            case 3:
            //                print("Favs")
            //            case 5:
        //                print("Profile")
        default:
            flowController.openModule(using: .openUnderConstruction) {
                guard ($0 as? UnderConstructionModuleInput) != nil else {fatalError()}
                return nil
            }
        }
    }

    func openChatModule() {
//        flowController.openModule(using: .openUnderConstructionModule) {
//            guard ($0 as? UnderConstructionModuleInput) != nil else {fatalError()}
//            return nil
//        }
    }

}

extension Segue {
//    static var openUnderConstructionModule: Segue<UnderConstructionViewController> {
//        return .init(identifier:"transitionToUnderConstruction")
//    }
}
