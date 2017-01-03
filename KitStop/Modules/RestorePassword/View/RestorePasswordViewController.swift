//
//  RestorePasswordViewController.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - RestorePasswordViewController

final class RestorePasswordViewController: UIViewController, FlowController, UITextFieldDelegate, Alertable {
    
    //MARK: - Outlets

    @IBOutlet weak var email: UITextField!

    @IBOutlet weak var submit: CustomButton!
    // MARK: - VIPER stack

    var presenter: RestorePasswordViewOutput!
    
    // MARK: - Life cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Restore Password"
        
        email.addTarget(self, action: #selector(textFieldDidChange), for: UIControlEvents.editingChanged)
        
        submit.isEnabled = false
    }

    // MARK: - Actions
    
    @IBAction func receiveSubmitTap(_ sender: AnyObject) {
        presenter.handleSubmitTap(email: email.text!)
    }
    
    
    func textFieldDidChange() {
        presenter.handleEditing(isEmpty: (email.text?.isEmpty)!)
    }
    
}

// MARK: - RestorePasswordViewInput

extension RestorePasswordViewController: RestorePasswordViewInput {
    func showAlert(message: String) {
        self.showAlertWithTitle("Error", message: message)
    }
    
    func dismissAfterAlert(message: String) {
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.presenter.dismissModule()
        }
        self.showAlertWithTitle("Success", message: message, actions: [action])
    }
    
    func changeSubmitStatus(status: Bool) {
        submit.isEnabled = status
    }
}

