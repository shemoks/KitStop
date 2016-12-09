//
//  SignUpRouter.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 08/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SignUpRouter

final class SignUpRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - SignUpRouterInput

extension SignUpRouter: SignUpRouterInput {

    func openLoginModule() {
//        flowController.openModule(using: .openLogIn) {
//            guard let _ = $0 as? LogInModuleInput else { fatalError() }
//            return nil
//        }
    }

}

//extension Segue {
//
//    static var openSignUp: Segue<LogInViewController> {
//        return .init(identifier: "LogIn")
//    }
//}
