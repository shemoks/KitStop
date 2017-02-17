//
//  MainSearchRouter.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - MainSearchRouter

final class MainSearchRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - MainSearchRouterInput

extension MainSearchRouter: MainSearchRouterInput {
    func closeModule() {
        flowController.closeModule(animated: true)
    }
    
    func openDetailedView(postID: String, ownerID: String, selectedSegment: Int,  moduleOutput: KitsDetailedModuleOutput, returnCase: ReturnCase) {
        switch selectedSegment {
        case 0:
            flowController.openModule(using: .openKitsDetailed) {
                guard let moduleInput = $0 as? KitsDetailedModuleInput else { fatalError() }
                moduleInput.dataForView(forSale: true, idPost: postID, idOwner: ownerID)
                moduleInput.flagFromSearch(search: true)
                moduleInput.returnCase(caseOf: returnCase)
                return moduleOutput
            }
        case 1:
            flowController.openModule(using: .openKitsDetailed) {
                guard let moduleInput = $0 as? KitsDetailedModuleInput else { fatalError() }
                moduleInput.dataForView(forSale: false, idPost: postID, idOwner: ownerID)
                moduleInput.flagFromSearch(search: true)
                moduleInput.returnCase(caseOf: returnCase)
                return moduleOutput
            }
        case 2:
            flowController.openModule(using: .openKitDetailed) {
                guard let moduleInput = $0 as? KitFolioDetailedModuleInput else { fatalError() }
                moduleInput.handleKitId(id: postID, ownerId: ownerID)
                return moduleOutput
            }
        default:
            print("Default")
        }
    }
    

}
