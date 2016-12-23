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
        // you must reference filter module 
        // router.openNextModule(secondModuleProtocol: 'Filter Module Output')
    }
    
    func openSearchModule() {
        // you must reference search module
        // router.openNextModule(secondModuleProtocol: 'Search Module Output')
    }
    
    func handleKitsForCategory(category: Int) {
        interactor.fetchKitsForCategory(category: category)
    }
}

// MARK: - MainFilterContainerInteractorOutput

extension MainFilterContainerPresenter: MainFilterContainerInteractorOutput {
    
}

// MARK: - MainFilterContainerModuleInput

extension MainFilterContainerPresenter: MainFilterContainerModuleInput {

}
