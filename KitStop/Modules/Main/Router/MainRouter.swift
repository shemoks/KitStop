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
    //    func openSecondModule(secondModuleOutput: 'SecondModuleOutput') {
    //        flowController.openModule(using: .openSecond) {
    //            guard let moduleInput = $0 as? 'SecondModuleInput' else { fatalError() }
    //            return nil
    //        }
    //    }
    func openModule(identifier: Int) {
        switch identifier {
            case 0:
                print("Activity")
            case 1:
                print("Conv")
            case 3:
                print("Favs")
            case 5:
                print("Profile")
            default:
                print("Nothing")
        }
    }
}

extension Segue {
    
  
    
}
