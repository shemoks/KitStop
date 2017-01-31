//
//  SelectImageViewInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - SelectImageViewInput
import UIKit

protocol SelectImageViewInput: class {
    func openCamera()
    func openGallary()
    func removeButton(button: UIButton)
    func presentActionSheet(actionSheet: UIAlertController)
}
