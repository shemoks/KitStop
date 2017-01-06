//
//  KitFolioCreateViewInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - KitFolioCreateViewInput
import UIKit

protocol KitFolioCreateViewInput: class {
    func addXibOnView(view: UIView)
    func showAlert(title: String, message: String)
    func showAlert(title: String, message: String, action: [UIAlertAction])
}
