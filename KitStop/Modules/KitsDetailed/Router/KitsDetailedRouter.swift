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
        flowController.openModule(using: .openUnderConstruction) {
            guard let moduleInput = $0 as? UnderConstructionModuleInput else {fatalError()}
            return nil
        }

    }

    func closeModule(section: Bool) {
        flowController.openModule(using: .openMainModule) {
            guard let moduleInput = $0 as? MainModuleInput else {fatalError()}
            moduleInput.passData(index: section)
            return nil
        }

    }

    func openEditKit(post: Post, oldModel: String, returnCase: ReturnCase) {
        flowController.openModule(using: .openEditKit) {
            guard let moduleInput = $0 as? CreatePostModuleInput else {fatalError()}
            moduleInput.setKitEdit(post: post, oldModel: oldModel)
            moduleInput.returnCase(caseOf: returnCase)
            return nil
        }
    }

    func openEditForSale(post: Post, oldModel: String, returnCase: ReturnCase) {
        flowController.openModule(using: .openEditKit) {
            guard let moduleInput = $0 as? CreatePostModuleInput else {fatalError()}
            moduleInput.setForSaleEdit(post: post, oldModel: oldModel)
            moduleInput.returnCase(caseOf: returnCase)
            return nil
        }
    }
}

extension Segue {

    static var openEditKit: Segue<CreatePostViewController> {
        return .init(identifier: "TrunsitionToEditPost")
}

}

