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

    @IBOutlet weak var facebook: FBSDKLoginButton!
    var presenter: SignUpViewOutput!

    @IBAction func loginEmailButtonTap(_ sender: AnyObject) {
        presenter.emailLogin()
    }

    @IBAction func signUpButtonTap(_ sender: Any) {
        presenter.signUp()
    }

    override func viewDidLoad() {
        facebook.titleLabel?.font = UIFont.init(name: "SFUIText-Regular", size: 17.0)
        let titleText = NSAttributedString(string: "Log in with Facebook")
        facebook.setAttributedTitle(titleText, for: .normal)
        
        let layoutConstraintsArr = facebook.constraints
        for lc in layoutConstraintsArr {
            if lc.constant == 28 {
                lc.isActive = false
                break
            }
        }
        
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        presenter.showButton()
    }

}

// MARK: - SignUpViewInput

extension SignUpViewController: SignUpViewInput {
    func setFacebookButtonVisible() {
        facebook.isHidden = false
    }
}

extension SignUpViewController: FBSDKLoginButtonDelegate {

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (error != nil) {
            print(error)
        } else if result.isCancelled{
            
        } else {
            let titleText = NSAttributedString(string: "Log in with Facebook")
            facebook.setAttributedTitle(titleText, for: .normal)
            presenter.handleFacebookLoginTap()

            LoadingIndicatorView.show()
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
}
