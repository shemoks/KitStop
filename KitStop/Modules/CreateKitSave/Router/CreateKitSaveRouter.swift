//
//  CreateKitSaveRouter.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import UIKit
import Perform

// MARK: - CreateKitSaveRouter

final class CreateKitSaveRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - CreateKitSaveRouterInput

extension CreateKitSaveRouter: CreateKitSaveRouterInput {
    func openDetailedModule(id: String) {
//        flowController.openModule(using: .openKitsDetailed) {
//            guard let moduleInput = $0 as? KitsDetailedModuleInput else { fatalError() }
//            moduleInput.dataForView(forSale: false, idPost:id)
//            return nil
//        }
    }
    
}

extension Segue {
//    static var openKitsDetailed: Segue<KitsDetailedViewController> {
//        return .init(identifier: "transitionToKitDetailedViewController")
//    }
}


