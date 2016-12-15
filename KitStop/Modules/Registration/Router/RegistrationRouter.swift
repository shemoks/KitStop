//
//  RegistrationRouter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 13/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Perform
import Chamomile
import UIKit

// MARK: - RegistrationRouter

final class RegistrationRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - RegistrationRouterInput

extension RegistrationRouter: RegistrationRouterInput {

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
