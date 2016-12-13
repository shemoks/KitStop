//
//  RegistrationTakePhotoPresenter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 12/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - RegistrationTakePhotoPresenter

final class RegistrationTakePhotoPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: RegistrationTakePhotoViewInput!
    var interactor: RegistrationTakePhotoInteractorInput!
    var router: RegistrationTakePhotoRouterInput!

}

// MARK: - RegistrationTakePhotoViewOutput

extension RegistrationTakePhotoPresenter: RegistrationTakePhotoViewOutput {

    func openGallery() {
        view.openGallery()
    }

    func openCamera() {
        view.openCamera()
    }

    func returnPhoto(photo: UIImage) {
        let RegistrationTakePhotoModuleOutput = moduleOutput as! RegistrationTakePhotoModuleOutput
        router.returnPhoto(photo: photo, moduleOutput: RegistrationTakePhotoModuleOutput)
    }

}

// MARK: - RegistrationTakePhotoInteractorOutput

extension RegistrationTakePhotoPresenter: RegistrationTakePhotoInteractorOutput {

}

// MARK: - RegistrationTakePhotoModuleInput

extension RegistrationTakePhotoPresenter: RegistrationTakePhotoModuleInput {

}
