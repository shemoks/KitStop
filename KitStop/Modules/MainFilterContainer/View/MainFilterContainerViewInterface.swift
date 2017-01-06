//
//  MainFilterContainerViewInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - MainFilterContainerViewInput

protocol MainFilterContainerViewInput: class {
    func transferKits(kits: [Product])
    func fetchKits()
    func showAlert(title: String, message: String)
}
