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
    fileprivate var upload = false

}

// MARK: - SignUpEmailViewOutput

extension SignUpEmailPresenter: SignUpEmailViewOutput {

    func takePhoto() {
        router.openModuleTakePhoto(RegistrationTakePhotoModuleOutput: self)
    }
    
    func comparePassword(password: String, repeatPassword: String) -> Bool {
        if password == repeatPassword && password != "" {
            return true
        } else {
            return false
        }
    }
    
    func registrationNewUser(userData: [String : String], userImage: UIImage) {
        let user: SignUpUserModel?
        if !upload {
            user = SignUpUserModel.init(email: userData["email"]!, password: userData["password"]!, userImage: nil)
        } else {
            user = SignUpUserModel.init(email: userData["email"]!, password: userData["password"]!, userImage: userImage)
        }
        interactor.addUser(user: user!)
        
    }

}

// MARK: - SignUpEmailInteractorOutput

extension SignUpEmailPresenter: SignUpEmailInteractorOutput {
    func openMainModule() {
        router.openMainModule()
    }
}

// MARK: - SignUpEmailModuleInput

extension SignUpEmailPresenter: SignUpEmailModuleInput {

}

extension SignUpEmailPresenter: RegistrationTakePhotoModuleOutput {

    func setImage(photo: UIImage) {
        view.getPhoto(photo: photo)
        upload = true
    }
    
}
