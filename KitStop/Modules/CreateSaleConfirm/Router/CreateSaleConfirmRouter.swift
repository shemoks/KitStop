//
//  CreateSaleConfirmRouter.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CreateSaleConfirmRouter

final class CreateSaleConfirmRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - CreateSaleConfirmRouterInput

extension CreateSaleConfirmRouter: CreateSaleConfirmRouterInput {
    func openList(list: [Other], customListModuleOutput: CustomListModuleOutput) {
//        flowController.openModule(using: .openList) {
//            guard let moduleInput = $0 as? CustomListModuleInput else { fatalError() }
//            moduleInput.setElements(list: list)
//            return customListModuleOutput
//        }
    }
}
