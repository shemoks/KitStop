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
    
    func openForgotPasswordModule() {
        flowController.openModule(using: .openForgotPassword) {
            guard ($0 as? RestorePasswordModuleInput) != nil else {fatalError()}
            
            return nil
        }
    }
    
    func openMainModule() {
        flowController.openModule(using: .openMainModule) {
            guard ($0 as? MainModuleInput) != nil else {fatalError()}
            
            return nil
        }
    }
}

extension Segue {
    
    // You need to reference Forget Password VC and identifier
    
    static var openForgotPassword: Segue<RestorePasswordViewController> {
        return .init(identifier:"transitionToRestorePassword")
    }
    
    static var openMainModule: Segue<MainViewController> {
        return .init(identifier:"transitionToMain")
    }
}
