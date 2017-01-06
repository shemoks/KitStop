//
//  SignUpEmailViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SignUpEmailViewController

final class SignUpEmailViewController: UIViewController, FlowController, CustomPasswordDelegateTextField, Alertable {

    // MARK: - VIPER stack
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var avatar: CustomAvatar!
    @IBOutlet weak var password: CustomPasswordTextField!
    @IBOutlet weak var repeatPassword: CustomPasswordTextField!
    @IBOutlet weak var email: UITextField!

    var presenter: SignUpEmailViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.passwordDelegate = self
        repeatPassword.passwordDelegate = self
        navigationController?.isNavigationBarHidden = false
    }

    func tapOnPasswordImageSuccess(textField: UITextField) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }

    @IBAction func tapOnSignUpButtonAction(_ sender: Any) {
        presenter.comparePassword(password: password.text!, repeatPassword: repeatPassword.text!)
    }
    
    func registrationNewUser() {
        LoadingIndicatorView.show(self.view)
        presenter.registrationNewUser(userData: getUserData(), userImage: avatar.image!)
    }
    
    func getUserData() -> [String : String] {
        let userData = ["email" : email.text!,
                        "password" : password.text!,
                        "name" : name.text!,
                        "surname" : surname.text!]
        return userData
    }
    
    func openNextModule() {
        presenter.comparePassword(password: password.text!, repeatPassword: repeatPassword.text!)
    }
    
    @IBAction func avatarTap(_ sender: UITapGestureRecognizer) {
        presenter.takePhoto()
    }

}

// MARK: - SignUpEmailViewInput

extension SignUpEmailViewController: SignUpEmailViewInput {

    func getPhoto(photo: UIImage) {
        avatar.image = photo
    }
    
    func showAlert(title: String, massage: String) {
        showAlertWithTitle(title, message: massage)
    }

}

extension SignUpEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.nextField?.becomeFirstResponder()
        return true
    }
}
