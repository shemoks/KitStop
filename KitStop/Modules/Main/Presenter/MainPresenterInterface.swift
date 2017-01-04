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
    func logoutFromFacebook()
}

// MARK: - MainInteractorOutput

protocol MainInteractorOutput: class {
    func updateKits(kits: [Product])
}

// MARK: - MainModuleInput

protocol MainModuleInput: ModuleInput {
}

// MARK: - MainModuleOutput

protocol MainModuleOutput: ModuleOutput {
}
