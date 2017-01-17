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

    func openSaveForSaleModule(post: Post) {
//        flowController.openModule(using: .openSaleConfirm) {
//            guard let moduleInput = $0 as? CreateSaleConfirmModuleInput else { fatalError() }
//            moduleInput.setPost(post: post)
//            return nil
//        }
    }

    func openSaveKitModule(post: Post) {
//        flowController.openModule(using: .openKitConfirm) {
            //            guard let moduleInput = $0 as? CreateKitConfirmModuleInput else { fatalError() }
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

//    func viewPhoto(images: [UIImage], viewPhotoModuleOutput: ViewPhotoModuleOutput) {
//        flowController.openModule(using: .openViewPhoto) {
//            guard let moduleInput = $0 as? ViewPhotoModuleInput else { fatalError() }
//            moduleInput.setPhoto(images: images)
//            return viewPhotoModuleOutput
//        }
//    }
}

extension Segue {

    static var openList: Segue<CustomListViewController> {
        return .init(identifier: "TrunsitionToCustomList")
    }

//  static var openSaleConfirm: Segue<CreateSaleConfirmViewController> {
        //        return .init(identifier: "TransitionToSaleConfirm")
        //    
//}

//    static var openViewPhoto: Segue<ViewPhotoViewController> {
//        return .init(identifier: "TrunsitionToViewPhoto")
//    }

//    static var openKitConfirm: Segue<CreateKitViewController> {
        //        return .init(identifier: "TransitionToSaleConfirm")
        //
        //
//    }
}
