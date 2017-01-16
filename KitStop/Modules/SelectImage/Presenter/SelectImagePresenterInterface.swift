//
//  SelectImagePresenterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SelectImageViewOutput

protocol SelectImageViewOutput: class {
    func openCamera()
    func openGallary()
    func cropImage(image: UIImage, buttons: [UIButton], delegate: SelectImageContainerProtocol?) -> UIImageView
}

// MARK: - SelectImageInteractorOutput

protocol SelectImageInteractorOutput: class {

}

// MARK: - SelectImageModuleInput

protocol SelectImageModuleInput: ModuleInput {

}

// MARK: - SelectImageModuleOutput

protocol SelectImageModuleOutput: ModuleOutput {

}
