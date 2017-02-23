//
//  MainSearchPresenterInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - MainSearchViewOutput

protocol MainSearchViewOutput: class {
    func kit(for indexPath: IndexPath) -> Product
    func numberOfKits() -> Int
    func handleSearchButtonTap(title: String)
    func closeModule()
    func setTitle() -> String
    func handleItemSelection(for indexPath: IndexPath)
    func refresh()
    
}

// MARK: - MainSearchInteractorOutput

protocol MainSearchInteractorOutput: class {
    func setKits(_ kits: [Product])
    func reloadData()
    func showAlert(title: String, message: String)
}

// MARK: - MainSearchModuleInput

protocol MainSearchModuleInput: ModuleInput {
    func setSegment(selectedSegment: Int)
}

// MARK: - MainSearchModuleOutput

protocol MainSearchModuleOutput: ModuleOutput {
    
}
