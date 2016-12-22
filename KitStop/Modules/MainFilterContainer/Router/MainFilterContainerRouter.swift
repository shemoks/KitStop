//
//  MainFilterContainerRouter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import UIKit
import Perform

// MARK: - MainFilterContainerRouter

final class MainFilterContainerRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - MainFilterContainerRouterInput

extension MainFilterContainerRouter: MainFilterContainerRouterInput {
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
