//
//  SignUpEmailPresenterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import UIKit

// MARK: - SignUpEmailViewOutput

protocol SignUpEmailViewOutput: class {

    func takePhoto()
    func comparePassword(password: String, repeatPassword: String)
    func registrationNewUser(userData: [String : String], userImage: UIImage, emailTF: UITextField)
    func checkUserName(name: String?, surname: String?, email: String, emailTF: UITextField) -> (Bool, Bool, Bool)
}

// MARK: - SignUpEmailInteractorOutput

protocol SignUpEmailInteractorOutput: class {
    func openMainModule()
    func showAlert(title: String, massage: String)
}

// MARK: - SignUpEmailModuleInput

protocol SignUpEmailModuleInput: ModuleInput {

}

// MARK: - SignUpEmailModuleOutput

protocol SignUpEmailModuleOutput: ModuleOutput {

}
