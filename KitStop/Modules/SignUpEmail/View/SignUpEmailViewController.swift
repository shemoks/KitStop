//
//  SignUpEmailViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SignUpEmailViewController

final class SignUpEmailViewController: UIViewController, FlowController, CustomPasswordDelegate {

    // MARK: - VIPER stack

    @IBOutlet weak var password: CustomPassword!
    @IBOutlet weak var repeatPassword: CustomPassword!
    
    var presenter: SignUpEmailViewOutput!
    
    override func viewDidLoad() {
        password.passwordDelegate = self
        repeatPassword.passwordDelegate = self
    }

    
    func tapOnPasswordImageSuccess(textField: UITextField) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }

    @IBAction func tapOnSignUpButtonAction(_ sender: Any) {

    }
}

// MARK: - SignUpEmailViewInput

extension SignUpEmailViewController: SignUpEmailViewInput {

}

extension SignUpEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.nextField?.becomeFirstResponder()
        return true
    }
}
