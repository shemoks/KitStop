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
    fileprivate var tapSignUpStatus = false
    fileprivate var choosePhoto: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.passwordDelegate = self
        repeatPassword.passwordDelegate = self
        password.delegate = self
        presenter.addBorder(email)
        presenter.addBorder(name)
        presenter.addBorder(surname)
        navigationController?.isNavigationBarHidden = false
        choosePhoto = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
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
    
    
    @IBAction func validateChangeFocus(_ sender: Any) {
        validate()
    }
    
    func tapOnPasswordImageSuccess(textField: UITextField) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }
    
    @IBAction func tapOnSignUpButtonAction(_ sender: Any) {
        tapSignUpStatus = true
        presenter.comparePassword(password: password.text!, repeatPassword: repeatPassword.text!)
    }
    
    func registrationNewUser() {
        LoadingIndicatorView.show()
        presenter.registrationNewUser(userData: getUserData(), userImage: avatar.image!, emailTF: self.email)
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
        choosePhoto = true
        presenter.takePhoto()
    }
    
    func validationFailedBorder(name: Bool, surname: Bool, email: Bool) {
        if name {
            self.name.layer.borderColor = UIColor.red.cgColor
        }
        else {
            self.name.layer.borderColor = UIColor.white.cgColor
        }
        if surname {
            self.surname.layer.borderColor = UIColor.red.cgColor
        } else {
            self.surname.layer.borderColor = UIColor.white.cgColor
        }
        if email {
            self.email.layer.borderColor = UIColor.red.cgColor
        } else {
            self.email.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    func validate() {
        if tapSignUpStatus {
            let validate = presenter.checkUserName(name: name.text, surname: surname.text, email: email.text!, emailTF: email)
            validationFailedBorder(name: validate.0, surname: validate.1, email: validate.2)
        }
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        validate()
    }
}
