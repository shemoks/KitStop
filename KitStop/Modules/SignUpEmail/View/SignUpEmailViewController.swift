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

    @IBOutlet weak var passwordTF: CustomPassword!
    @IBOutlet weak var repeatPasswordTF: CustomPassword!
    
    var presenter: SignUpEmailViewOutput!
    
    override func viewDidLoad() {
        passwordTF.passwordDelegate = self
        repeatPasswordTF.passwordDelegate = self
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
