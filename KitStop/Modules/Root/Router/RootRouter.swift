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
//        flowController.openModule(using: .openSignUp) {
//            guard let moduleInput = $0 as? SecondModuleInput else { fatalError()}
//            moduleInput.getSum(number: number)
//            return secondModuleOutput
//        }
    }

    func changeModuleMain() {

    }
}

extension Segue {

//    static var openSignUp: Segue<SignUpViewController> {
//        return .init(identifier: "SignUp")
//    }

//    static var openMain: Segue<MainViewController> {
//        return .init(identifier: "Main")
//    }

}
