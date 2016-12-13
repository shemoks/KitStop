//
//  RegistrationTakePhotoPresenterInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 12/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - RegistrationTakePhotoViewOutput

protocol RegistrationTakePhotoViewOutput: class {

    func openGallery()
    func openCamera()
    func returnPhoto(photo: UIImage)
    
}

// MARK: - RegistrationTakePhotoInteractorOutput

protocol RegistrationTakePhotoInteractorOutput: class {

}

// MARK: - RegistrationTakePhotoModuleInput

protocol RegistrationTakePhotoModuleInput: ModuleInput {

}

// MARK: - RegistrationTakePhotoModuleOutput

protocol RegistrationTakePhotoModuleOutput: ModuleOutput {

    func setImage(photo: UIImage)
    
}
