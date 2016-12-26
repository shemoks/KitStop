//
//  SignUpEmailViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SignUpEmailViewController

final class SignUpEmailViewController: UIViewController, FlowController, CustomPasswordDelegateTextField {

    // MARK: - VIPER stack
    
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

//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.isNavigationBarHidden = false
//    }

    func tapOnPasswordImageSuccess(textField: UITextField) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }


    @IBAction func tapOnSignUpButtonAction(_ sender: Any) {
        if presenter.comparePassword(password: password.text!, repeatPassword: repeatPassword.text!) {
            let userData = ["email" : email.text!,
                            "password" : password.text!]
            presenter.registrationNewUser(userData: userData)
        }
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

}

extension SignUpEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.nextField?.becomeFirstResponder()
        return true
    }
}
