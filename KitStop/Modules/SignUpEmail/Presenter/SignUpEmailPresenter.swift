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
    
    func comparePassword(password: String, repeatPassword: String) {
        if password == repeatPassword && password != "" {
            view.registrationNewUser()
        } else {
            let errorMassage = CustomError.init(code: 10002).description
            view.showAlert(title: "Error", massage: errorMassage)
        }
    }
    
    func registrationNewUser(userData: [String : String], userImage: UIImage, emailTF: UITextField) {
        let user: SignUpUserModel?
        let name = userData["name"]!
        let surname = userData["surname"]!
        let email = userData["email"]!
        if !upload {
            user = SignUpUserModel.init(email: email, password: userData["password"]!, userImage: nil, name: name, surname: surname)
        } else {
            user = SignUpUserModel.init(email: email, password: userData["password"]!, userImage: userImage, name: name, surname: surname)
        }
        let status = checkUserName(name: name, surname: surname, email: email, emailTF: emailTF)
        if !status.0 && !status.1 && !status.2 {
            interactor.addUser(user: user!)
        } else {
            LoadingIndicatorView.hide()
            view.validationFailedBorder(name: status.0, surname: status.1, email: status.2)
        }
        
    }
    
    func checkUserName(name: String?, surname: String?, email: String, emailTF: UITextField) -> (Bool, Bool, Bool) {
        var nameStatus = false
        var surnameStatus = false
        var emailStatus = false
        if name == "" {
            nameStatus = true
        }
        if surname == "" {
            surnameStatus = true
        }
        if email == "" || UITextField().checkIfEmailIsValid(email: emailTF) {
            emailStatus = true
        }
        return (nameStatus, surnameStatus, emailStatus)
    }
    
    func addBorder(_ textField: UITextField) {
        textField.layer.borderWidth = 2.5
        textField.layer.borderColor = UIColor.white.cgColor
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
