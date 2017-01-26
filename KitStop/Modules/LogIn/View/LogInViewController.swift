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
    fileprivate var forgotOppened: Bool = false
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.clearTextFields()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        login.isEnabled = true
        if let navController = self.navigationController {
            if !forgotOppened {
                navController.navigationBar.isHidden = true
                for controller in navController.viewControllers as Array {
                    if controller.isKind(of: SignUpViewController.self) {
                        let _ = self.navigationController?.popToViewController(controller as! SignUpViewController, animated: false)
                        break
                    }
                }
            } else {
                forgotOppened = false
            }
        }
    }
    
    override func viewDidLoad() {
        password.passwordDelegate = self
        password.email = email
        email.layer.borderWidth = 2.5
        email.layer.borderColor = UIColor.white.cgColor
        forgotOppened = false
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
        forgotOppened = true
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
