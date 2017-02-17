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

    func openMainModule() {
        flowController.openModule(using: .openMainModule) {
            guard let moduleInput = $0 as? MainModuleInput else { fatalError() }
            moduleInput.passData(index: false)
            return nil
        }
    }

    func openSearchModule() {
        flowController.openModule(using: .openMainSearch) {
            guard let moduleInput = $0 as? MainSearchModuleInput else { fatalError() }
    //        moduleInput.passData(index: false)
            return nil
        }
    }

    func openKitsDetailedModule() {
        flowController.openModule(using: .openKitsDetailed) {
            guard let moduleInput = $0 as? KitsDetailedModuleInput else { fatalError() }
            //        moduleInput.passData(index: false)
            return nil
        }
    }

}


