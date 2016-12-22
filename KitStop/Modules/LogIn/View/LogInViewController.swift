//
//  LogInViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 08/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import UIKit

// MARK: - LogInViewController

final class LogInViewController: UIViewController, FlowController, CustomPasswordTFDelegate {

    // MARK: - VIPER stack
    var presenter: LogInViewOutput!
    
    @IBOutlet weak var passwordTF: CustomPasswordTF!
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        emailTF.delegate = self
        passwordTF.passwordDelegate = self
    }
    
    func tapOnPasswordImageSuccess(textField: UITextField) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }

    @IBAction func tapOnLoginButton(_ sender: Any) {
        var userData: Dictionary = [String : String]() as Dictionary
        userData["login"] = emailTF.text
        userData["password"] = passwordTF.text
        presenter.handleUserData(userData: userData)
    }
    
    @IBAction func tapOnForgetButton(_ sender: Any) {
        presenter.openForgetPasswordModule()
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        passwordTF.becomeFirstResponder()
        return false
    }
}

// MARK: - LogInViewInput

extension LogInViewController: LogInViewInput {

}