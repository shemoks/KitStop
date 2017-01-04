//
//  MainRouter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import UIKit
import Perform

// MARK: - MainRouter

final class MainRouter {
    
    // MARK: - VIPER stack
    
    weak var flowController: FlowController!
    
}

// MARK: - MainRouterInput

extension MainRouter: MainRouterInput {
    func openCategoryModule(secondModuleOutput: SelectCategoryModuleOutput) {
        flowController.openModule(using: .openCategoryList) {
            guard ($0 as? SelectCategoryModuleInput) != nil else { fatalError() }
            return nil
        }
    }
    
    func openKitFolioCreateModule(secondModuleOutput: KitFolioCreateModuleOutput) {
        flowController.openModule(using: .openKitFolioCreate) {
            guard ($0 as? KitFolioCreateModuleInput) != nil else { fatalError() }
            return nil
        }
    }
}

extension Segue {
    
    static var openCategoryList: Segue<SelectCategoryViewController> {
        return .init(identifier: "transitionToCategoryList")
    }
    
    static var openKitFolioCreate: Segue<KitFolioCreateViewController> {
        return .init(identifier: "transitionToKitFolioCreate")
    }

    
}
