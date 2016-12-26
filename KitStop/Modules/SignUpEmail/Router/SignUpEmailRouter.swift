//
//  SignUpEmailRouter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import Perform
import UIKit

// MARK: - SignUpEmailRouter

final class SignUpEmailRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - SignUpEmailRouterInput

extension SignUpEmailRouter: SignUpEmailRouterInput {

    func openModuleTakePhoto(RegistrationTakePhotoModuleOutput: RegistrationTakePhotoModuleOutput) {
        flowController.openModule(using: .openSecond) {
            guard ($0 as? RegistrationTakePhotoModuleInput) != nil else { fatalError() }
            return RegistrationTakePhotoModuleOutput
        }
    }
}

extension Segue {

    static var openSecond: Segue<RegistrationTakePhotoViewController> {
        return .init(identifier: "ShowTakePhoto")
    }
    
}
