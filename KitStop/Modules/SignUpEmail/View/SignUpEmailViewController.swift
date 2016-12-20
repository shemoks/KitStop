//
//  SignUpEmailViewController.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SignUpEmailViewController

final class SignUpEmailViewController: UIViewController, FlowController, CustomPasswordTFDelegate, UIGestureRecognizerDelegate {

    // MARK: - VIPER stack

    @IBOutlet weak var imageView: CustomAvatar!
    @IBOutlet weak var passwordTF: CustomPasswordTF!
    @IBOutlet weak var repeatPasswordTF: CustomPasswordTF!
    
    var presenter: SignUpEmailViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(takePhoto))
        tapImageView.delegate = self
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapImageView)
        passwordTF.passwordDelegate = self
        repeatPasswordTF.passwordDelegate = self
    }
    
    func tapOnPasswordImageSuccess(textField: UITextField) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }

    func takePhoto(_ gestureRecognizer: UITapGestureRecognizer) {
        presenter.takePhoto()
    }

    @IBAction func tapOnSignUpButtonAction(_ sender: Any) {

    }
}

// MARK: - SignUpEmailViewInput

extension SignUpEmailViewController: SignUpEmailViewInput {

    func getPhoto(photo: UIImage) {
        imageView.image = photo
    }

}
