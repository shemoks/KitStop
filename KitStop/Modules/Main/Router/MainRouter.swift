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
    func openCategoryModule(secondModuleOutput: SelectCategoryModuleOutput, category: Bool, returnCase: ReturnCase) {
        flowController.openModule(using: .openCategoryList) {
            guard let moduleInput = $0 as? SelectCategoryModuleInput else { fatalError() }
            moduleInput.handleCategory(category: category)
            moduleInput.returnCase(caseOf: returnCase)
            return nil
        }
    }
    
    func openKitFolioCreateModule(secondModuleOutput: KitFolioCreateModuleOutput, returnCase: ReturnCase) {
        flowController.openModule(using: .openKitFolioCreate) {
            guard ($0 as? KitFolioCreateModuleInput) != nil else { fatalError() }
            return secondModuleOutput
        }
    }
    func openModule(identifier: Int) {
        switch identifier {
//            case 0:
//                print("Activity")
//            case 1:
//                print("Conv")
            case 2:
                print("Main")
//            case 3:
//                print("Favs")
            case 4:
                print("Profile")
                flowController.openModule(using: .openUnderConstruction) {
                    guard let moduleInput = $0 as? UnderConstructionModuleInput else {fatalError()}
                    moduleInput.addLogOut()
                    return nil
            }

            default:
                flowController.openModule(using: .openUnderConstruction) {
                    guard ($0 as? UnderConstructionModuleInput) != nil else {fatalError()}
                    return nil
                }
        }
    }
}

extension Segue {
    
    static var openCategoryList: Segue<SelectCategoryViewController> {
        return .init(identifier: "transitionToCategoryList")
    }
    static var openUnderConstruction: Segue<UnderConstructionViewController> {
        return .init(identifier:"transitionToUnderConstruction")
    }
  
    
    static var openKitFolioCreate: Segue<KitFolioCreateViewController> {
        return .init(identifier: "transitionToKitFolioCreate")
    }

    
}
