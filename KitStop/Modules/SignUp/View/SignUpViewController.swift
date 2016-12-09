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
}

// MARK: - SignUpViewInput

extension SignUpViewController: SignUpViewInput {

}

extension SignUpViewController: FBSDKLoginButtonDelegate {
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("done")
        print()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
}
