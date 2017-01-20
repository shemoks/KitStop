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
    
}

// MARK: - MainSearchInteractorOutput

protocol MainSearchInteractorOutput: class {
    func setKits(_ kits: [Product])
    func reloadData()
}

// MARK: - MainSearchModuleInput

protocol MainSearchModuleInput: ModuleInput {
    func setSegment(selectedSegment: Int)
}

// MARK: - MainSearchModuleOutput

protocol MainSearchModuleOutput: ModuleOutput {
    
}
