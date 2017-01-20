//
//  MainSearchViewInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - MainSearchViewInput

protocol MainSearchViewInput: class {
    func reloadData()
    func showAlert(message: String)
}
