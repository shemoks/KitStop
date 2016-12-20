//
//  LogInRouter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 08/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import UIKit
import Perform
// MARK: - LogInRouter

final class LogInRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - LogInRouterInput

extension LogInRouter: LogInRouterInput {
    // You need to reference Forget Password Output Protocol
    
//    func openNextModule(secondModule: 'Some Module') {
//        flowController.openModule(using: .openSecond) {
//            return secondModuleOutput
//        }
//    }
}

extension Segue {
    
    // You need to reference Forget Password VC and identifier
    
//    static var openSecond: Segue<> {
//        return .init(identifier: "someIdentifier")
//    }
}
