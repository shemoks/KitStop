//
//  SelectCategoryRouter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import Perform

// MARK: - SelectCategoryRouter

final class SelectCategoryRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - SelectCategoryRouterInput

extension SelectCategoryRouter: SelectCategoryRouterInput {

    func openAddKitModule(categoryID: String, category: Bool) {
        // flowController.openModule
    }
}

extension Segue {
//    static var openAddKitModule: Segue<> {
//        return .init(identifier: "transitionToAddKitModule")
//    }
}
