//
//  MainFilterContainerPresenterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - MainFilterContainerViewOutput

protocol MainFilterContainerViewOutput: class {
    func openFilterModule(selectedIndex: Int)
    func openSearchModule()
    func handleKitsForCategory(category: Int, transferData: MainFilterContainerTransferDataProtocol?, filterButton: UIButton)
}

// MARK: - MainFilterContainerInteractorOutput

protocol MainFilterContainerInteractorOutput: class {

}

// MARK: - MainFilterContainerModuleInput

protocol MainFilterContainerModuleInput: ModuleInput {

}

// MARK: - MainFilterContainerModuleOutput

protocol MainFilterContainerModuleOutput: ModuleOutput {
    
}
