//
//  MainPresenterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - MainViewOutput

protocol MainViewOutput: class {
    func setupAlert()
    func handleKitForSale()
    func openModule(identifier: Int)
}

// MARK: - MainInteractorOutput

protocol MainInteractorOutput: class {
    func updateKits(kits: [Product])
    func showAlert(title: String, message: String)
}

// MARK: - MainModuleInput

protocol MainModuleInput: ModuleInput {
    
}

// MARK: - MainModuleOutput

protocol MainModuleOutput: ModuleOutput {
    func updateKitFolioItems()
}
