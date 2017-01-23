//
//  SignUpEmailViewInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - SignUpEmailViewInput
import UIKit

protocol SignUpEmailViewInput: class {
    func showAlert(title: String, massage: String)
    func getPhoto(photo: UIImage)
    func registrationNewUser()
    func validationFailedBorder(name: Bool, surname: Bool)
}
