//
//  RegistrationTakePhotoRouterInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 12/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//
import UIKit

// MARK: - RegistrationTakePhotoRouterInput

protocol RegistrationTakePhotoRouterInput: class {

    func returnPhoto(photo: UIImage, moduleOutput: RegistrationTakePhotoModuleOutput)
    
}
