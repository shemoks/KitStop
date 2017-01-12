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
//        flowController.openModule(using: .openSecond) {
//            guard let moduleInput = $0 as? CreateSaleConfirmModuleInput else { fatalError() }
//            moduleInput.setPost(post: post)
//            return nil
//        }
    }
}
extension Segue {

//    static var openSecond: Segue<CreateSaleConfirmViewController> {
//        return .init(identifier: "TransitionToSaleConfirm")
//    }

}
