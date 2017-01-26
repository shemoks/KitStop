//
//  KitFolioDetailedViewInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - KitFolioDetailedViewInput
import UIKit

protocol KitFolioDetailedViewInput: class {
    func addXibOnView(view: UIView)
    func updateProduct(product: Product, user: User?)
    func presentAlert(alert: UIAlertController)
    func presentPicker()
    func showAlert(title: String, message: String)
    func showSuccessAlert(title: String, message: String, action: [UIAlertAction])
    func refreshDataAfterUpdate(isSizeChange: Bool)
    func edit()
}
