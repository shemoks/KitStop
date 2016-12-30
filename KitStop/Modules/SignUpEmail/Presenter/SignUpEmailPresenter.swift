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
        let name = checkUserName(name: userData["name"]!)
        let surname = userData["surname"]!
        if !upload {
            user = SignUpUserModel.init(email: userData["email"]!, password: userData["password"]!, userImage: nil, name: name, surname: surname)
        } else {
            user = SignUpUserModel.init(email: userData["email"]!, password: userData["password"]!, userImage: userImage, name: name, surname: surname)
        }
        interactor.addUser(user: user!)
        
    }
    
    func checkUserName(name: String?) -> String? {
        if name == "" {
            return nil
        } else {
            return name!
        }
    }

}

// MARK: - SignUpEmailInteractorOutput

extension SignUpEmailPresenter: SignUpEmailInteractorOutput {
    func openMainModule() {
        router.openMainModule()
    }
    
    func showAlert(title: String, massage: String) {
        view.showAlert(title: title, massage: massage)
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
