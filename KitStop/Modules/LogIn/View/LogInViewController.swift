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

final class LogInViewController: UIViewController, FlowController {

    // MARK: - VIPER stack
    var presenter: LogInViewOutput!
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        emailTF.delegate = self
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
