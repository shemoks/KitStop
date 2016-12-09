//
//  RootRouter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 09/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//
import Perform
import Chamomile
import UIKit

// MARK: - RootRouter

final class RootRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - RootRouterInput

extension RootRouter: RootRouterInput {

    func changeModuleSignUp() {
        flowController.openModule(using: .openSignUp) {
            guard let _ = $0 as? SignUpModuleInput else { fatalError() }
            return nil
        }
    }

    func changeModuleMain() {
//        flowController.openModule(using: .openMain) {
//            guard ($0 as? MainModuleInput) != nil else { fatalError()}
//            return nil
//        }
    }
}

extension Segue {

    static var openSignUp: Segue<SignUpViewController> {
        return .init(identifier: "Registration")
    }

//    static var openMain: Segue<ViewController> {
//        return .init(identifier: "Main")
//    }

}
