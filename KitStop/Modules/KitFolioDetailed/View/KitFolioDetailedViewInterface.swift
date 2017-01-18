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
    func addToolBar(toolBar: UIView)
    func updateProduct(product: Product, user: User?)
}
