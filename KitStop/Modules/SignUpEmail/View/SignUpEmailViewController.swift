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

    @IBAction func avatarTap(_ sender: UITapGestureRecognizer) {
        presenter.takePhoto()
    }
    @IBOutlet weak var avatar: CustomAvatar!
    @IBOutlet weak var password: CustomPassword!
    @IBOutlet weak var repeatPassword: CustomPassword!
    

    var presenter: SignUpEmailViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    func getPhoto(photo: UIImage) {
        avatar.image = photo
    }

}
