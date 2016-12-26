//
//  SignUpViewController.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 08/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import FBSDKLoginKit

// MARK: - SignUpViewController

final class SignUpViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: SignUpViewOutput!

    @IBAction func loginEmailButtonTap(_ sender: AnyObject) {
        presenter.emailLogin()
    }

    @IBAction func signUpButtonTap(_ sender: Any) {
        presenter.signUp()
    }

    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

}

// MARK: - SignUpViewInput

extension SignUpViewController: SignUpViewInput {

}

extension SignUpViewController: FBSDKLoginButtonDelegate {


    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
}
