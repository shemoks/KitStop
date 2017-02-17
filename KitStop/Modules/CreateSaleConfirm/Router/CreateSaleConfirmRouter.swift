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
    func openList(list: [Other], customListModuleOutput: CustomListModuleOutput, name: String) {
        flowController.openModule(using: .openList) {
            guard let moduleInput = $0 as? CustomListModuleInput else { fatalError() }
            moduleInput.setElements(list: list, name: name)
            return customListModuleOutput
        }
    }

    func openMain() {
        flowController.openModule(using: .openMainModule) {
            guard let moduleInput = $0 as? MainModuleInput else { fatalError() }
            moduleInput.passData(index: true)
            return nil
        }
    }

    func openMainSearch() {
        flowController.openModule(using: .openMainSearch) {
            guard let moduleInput = $0 as? MainSearchModuleInput else { fatalError() }
           // moduleInput.passData(index: true)
            return nil
        }
    }

    func openDetailedKit() {
        flowController.openModule(using: .openKitsDetailed) {
            guard let moduleInput = $0 as? KitsDetailedModuleInput else { fatalError() }
            // moduleInput.passData(index: true)
            return nil
        }
    }
}
