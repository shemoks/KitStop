//
//  SignUpEmailPresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SignUpEmailPresenter

final class SignUpEmailPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: SignUpEmailViewInput!
    var interactor: SignUpEmailInteractorInput!
    var router: SignUpEmailRouterInput!

}

// MARK: - SignUpEmailViewOutput

extension SignUpEmailPresenter: SignUpEmailViewOutput {

    func takePhoto() {
        router.openModuleTakePhoto(RegistrationTakePhotoModuleOutput: self)
    }

}

// MARK: - SignUpEmailInteractorOutput

extension SignUpEmailPresenter: SignUpEmailInteractorOutput {

}

// MARK: - SignUpEmailModuleInput

extension SignUpEmailPresenter: SignUpEmailModuleInput {

}

extension SignUpEmailPresenter: RegistrationTakePhotoModuleOutput {

    func setImage(photo: UIImage) {
        view.getPhoto(photo: photo)
    }
    
}
