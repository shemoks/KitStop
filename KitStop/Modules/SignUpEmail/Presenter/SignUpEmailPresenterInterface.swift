//
//  SignUpEmailPresenterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SignUpEmailViewOutput

protocol SignUpEmailViewOutput: class {

    func takePhoto()
    func comparePassword(password: String, repeatPassword: String) -> Bool
    func registrationNewUser(userData: [String : String])
}

// MARK: - SignUpEmailInteractorOutput

protocol SignUpEmailInteractorOutput: class {

}

// MARK: - SignUpEmailModuleInput

protocol SignUpEmailModuleInput: ModuleInput {

}

// MARK: - SignUpEmailModuleOutput

protocol SignUpEmailModuleOutput: ModuleOutput {

}
