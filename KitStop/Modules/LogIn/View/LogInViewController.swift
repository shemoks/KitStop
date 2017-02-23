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
    
    @IBOutlet weak var login: CustomButton!
    @IBOutlet weak var password: CustomPasswordTextField!
    @IBOutlet weak var email: UITextField!
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.clearTextFields()
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Log in"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.setLeftBarButton(nil, animated: false)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLoad() {
        password.passwordDelegate = self
        password.email = email
        email.layer.borderWidth = 2.5
        email.layer.borderColor = UIColor.white.cgColor
        navigationController?.title = "Log in"
    }
    
    func clearTextFields() {
        self.password.text = ""
        self.email.text = ""
    }
    
    func tapOnPasswordImageSuccess(textField: UITextField) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }
    
    @IBAction func tapOnLoginButton(_ sender: Any) {
        login.isEnabled = false
        presenter.handleUserData(userData: getUserData())
    }
    
    func getUserData() -> Dictionary<String, String> {
        var userData: Dictionary = [String : String]() as Dictionary
        userData["login"] = email.text
        userData["password"] = password.text
        return userData
    }
    
    @IBAction func tapOnForgetButton(_ sender: Any) {
        presenter.openForgetPasswordModule()
    }
    
    func openNextModule() {
        presenter.handleUserData(userData: getUserData())
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.nextField?.becomeFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UITextField().checkFieldFrom(email: email, textField: textField)
    }
}

// MARK: - LogInViewInput

extension LogInViewController: LogInViewInput {
    
    func showAlert(title: String, massage: String) {
        login.isEnabled = true
        showAlertWithTitle(title, message: massage)
    }
}
