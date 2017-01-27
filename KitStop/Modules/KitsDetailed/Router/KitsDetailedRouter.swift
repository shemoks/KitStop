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

    func openFullScreen(index: Int, images: [UIImage], isEdit: Bool) {
//        flowController.openModule(using: .openUnderConstruction) {
//            guard let moduleInput = $0 as? UnderConstructionModuleInput else {fatalError()}
//            return nil
//        }

    }

    func openChatModule() {
        flowController.openModule(using: .openUnderConstruction) {
            guard let moduleInput = $0 as? UnderConstructionModuleInput else {fatalError()}
            return nil
        }

    }

    func closeModule(moduleOutput: KitsDetailedModuleOutput, section: Bool) {
        if section {
            moduleOutput.updateKitForSale()
            self.flowController.closeModule(animated: true)
        } else {
            moduleOutput.updateKits()
            self.flowController.closeModule(animated: true)
        }

    }

    func openEditKit(post: Post) {
        flowController.openModule(using: .openEditKit) {
            guard let moduleInput = $0 as? CreatePostModuleInput else {fatalError()}
            moduleInput.setKitEdit(post: post)
            return nil
        }
    }

    func openEditForSale(post: Post) {
        flowController.openModule(using: .openEditKit) {
            guard let moduleInput = $0 as? CreatePostModuleInput else {fatalError()}
            moduleInput.setForSaleEdit(post: post)
            return nil
        }
    }
}

extension Segue {

    static var openEditKit: Segue<CreatePostViewController> {
        return .init(identifier: "TrunsitionToEditPost")
}

}

