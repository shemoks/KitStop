//
//  MainFilterContainerPresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - MainFilterContainerPresenter

final class MainFilterContainerPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: MainFilterContainerViewInput!
    var interactor: MainFilterContainerInteractorInput!
    var router: MainFilterContainerRouterInput!
    
}

// MARK: - MainFilterContainerViewOutput

extension MainFilterContainerPresenter: MainFilterContainerViewOutput {
    
    func openFilterModule() {
        router.openFilterModule(filterModuleOutput: self)
    }
    
    func openSearchModule() {
        // you must reference search module
        // router.openNextModule(secondModuleProtocol: 'Search Module Output')
    }
    
    func handleKitsForCategory(category: Int, transferData trasferData: MainFilterContainerTransferDataProtocol?, filterButton: UIButton) {
        interactor.fetchKitsForCategory(category: category, transferData: trasferData, filterButton: filterButton)
    }
}

// MARK: - MainFilterContainerInteractorOutput

extension MainFilterContainerPresenter: MainFilterContainerInteractorOutput {
    
}

// MARK: - MainFilterContainerModuleInput

extension MainFilterContainerPresenter: MainFilterContainerModuleInput {
}

extension MainFilterContainerPresenter: FiltersModuleOutput{
    func kitsWithFilters(kits: [Product]) {
        print("Uraaa")
    }
}
