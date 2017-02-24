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

    func openSaveForSaleModule(post: Post, images: PostImagesModel, shouldUpdate: Bool, oldModel: String, returnCase: ReturnCase) {
        flowController.openModule(using: .openSaleConfirm) {
            guard let moduleInput = $0 as? CreateSaleConfirmModuleInput else { fatalError() }
            moduleInput.setPost(with: post)
            moduleInput.setUpdate(shouldUpdate: shouldUpdate, oldModel: oldModel)
            moduleInput.setImages(images: images)
            moduleInput.returnCase(caseOf: returnCase)
            return nil
        }
    }

    func openSaveKitModule(post: Post, images: PostImagesModel, shouldUpdate: Bool, oldModel: String, returnCase: ReturnCase) {
        flowController.openModule(using: .openKitConfirm) {
            guard let moduleInput = $0 as? CreateKitSaveModuleInput else { fatalError() }
            moduleInput.setPost(post: post)
            moduleInput.setUpdate(shouldUpdate: shouldUpdate, oldModel: oldModel)
            moduleInput.setImages(images: images)
            moduleInput.returnCase(caseOf: returnCase)
            return nil
        }
    }

    func openList(list: [Other], customListModuleOutput: CustomListModuleOutput, name: String) {
        flowController.openModule(using: .openList) {
            guard let moduleInput = $0 as? CustomListModuleInput else { fatalError() }
            moduleInput.setElements(list: list, name: name)
            return customListModuleOutput
        }
    }

    func openUnderConstruction() {
        flowController.openModule(using: .openUnderConstruction) {
            guard ($0 as? UnderConstructionModuleInput) != nil else { fatalError() }
            return nil
        }
    }

}

extension Segue {

    static var openList: Segue<CustomListViewController> {
        return .init(identifier: "TrunsitionToCustomList")
    }

  static var openSaleConfirm: Segue<CreateSaleConfirmViewController> {
                return .init(identifier: "TransitionToSaleConfirm")
            
  }

    static var openKitConfirm: Segue<CreateKitSaveViewController> {
                return .init(identifier: "TransitionToKitConfirm")
    }

}
