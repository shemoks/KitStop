//
//  CreatePostRouter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import Perform

// MARK: - CreatePostRouter

final class CreatePostRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - CreatePostRouterInput

extension CreatePostRouter: CreatePostRouterInput {

    func openPriceModule(post: Post) {
//        flowController.openModule(using: .openSaleConfirm) {
//            guard let moduleInput = $0 as? CreateSaleConfirmModuleInput else { fatalError() }
//            moduleInput.setPost(post: post)
//            return nil
//        }
    }

    func openList(list: [Other], customListModuleOutput: CustomListModuleOutput) {
        flowController.openModule(using: .openList) {
            guard let moduleInput = $0 as? CustomListModuleInput else { fatalError() }
            moduleInput.setElements(list: list)
            return customListModuleOutput
        }
    }
}

extension Segue {

    static var openList: Segue<CustomListViewController> {
        return .init(identifier: "TrunsitionToCustomList")
    }

//  static var openSaleConfirm: Segue<CreateSaleConfirmViewController> {
        //        return .init(identifier: "TransitionToSaleConfirm")
        //    
//}
}
