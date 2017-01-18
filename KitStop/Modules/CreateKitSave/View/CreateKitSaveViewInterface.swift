//
//  CreateKitSaveViewInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - CreateKitSaveViewInput

protocol CreateKitSaveViewInput: class {
    func reloadData()
    func showAlert(title: String, message: String)
}
