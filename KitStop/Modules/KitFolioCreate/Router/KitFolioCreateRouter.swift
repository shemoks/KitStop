//
//  KitFolioCreateRouter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - KitFolioCreateRouter

final class KitFolioCreateRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - KitFolioCreateRouterInput

extension KitFolioCreateRouter: KitFolioCreateRouterInput {
    func returnToMainModule(moduleOutput: MainModuleOutput) {
        moduleOutput.updateKitFolioItems()
        flowController.openModule(using: .openMainModule) {
            guard let moduleInput = $0 as? MainModuleInput else { fatalError() }
            return nil
        }
    }

    func openMainModule() {
        flowController.openModule(using: .openMainModule) {
            guard let moduleInput = $0 as? MainModuleInput else { fatalError() }
            return nil
        }
    }
}
