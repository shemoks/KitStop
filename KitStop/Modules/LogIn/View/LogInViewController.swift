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

final class LogInViewController: UIViewController, FlowController, Alertable, CustomPasswordDelegateTextField {

    // MARK: - VIPER stack
    var presenter: LogInViewOutput!
    
    @IBOutlet weak var password: CustomPasswordTextField!
    @IBOutlet weak var email: UITextField!
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        presenter.clearTextFields()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        password.passwordDelegate = self
    }
    
    func clearTextFields() {
        self.password.text = ""
        self.email.text = ""
    }
    
    func tapOnPasswordImageSuccess(textField: UITextField) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }

    @IBAction func tapOnLoginButton(_ sender: Any) {
        var userData: Dictionary = [String : String]() as Dictionary
        userData["login"] = email.text
        userData["password"] = password.text
        presenter.handleUserData(userData: userData)
    }
    
    @IBAction func tapOnForgetButton(_ sender: Any) {
        presenter.openForgetPasswordModule()
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.nextField?.becomeFirstResponder()
        return true
    }
}

// MARK: - LogInViewInput

extension LogInViewController: LogInViewInput {
    
    func showAlert(title: String, massage: String) {
        showAlertWithTitle(title, message: massage)
    }
}
