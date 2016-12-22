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
}

extension Segue {
    
    //    you must reference second controller and identity
    //    static var openSecond: Segue<SecondViewController> {
    //        return .init(identifier: "transitionToNext")
    //    }
    
}
