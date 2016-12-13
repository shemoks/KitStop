//
//  RegistrationTakePhotoRouter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 12/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - RegistrationTakePhotoRouter

final class RegistrationTakePhotoRouter {

    // MARK: - VIPER stack

    weak var flowController: FlowController!

}

// MARK: - RegistrationTakePhotoRouterInput

extension RegistrationTakePhotoRouter: RegistrationTakePhotoRouterInput {

    func returnPhoto(photo: UIImage, moduleOutput: RegistrationTakePhotoModuleOutput) {
        moduleOutput.setImage(photo: photo)
    }
    
}
