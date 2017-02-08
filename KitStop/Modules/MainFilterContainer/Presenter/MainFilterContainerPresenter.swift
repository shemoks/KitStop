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
    
    func openFilterModule(selectedIndex: Int) {
        router.openFilterModule(selectedIndex: selectedIndex ,filterModuleOutput: self)
    }
    
    func openSearchModule(selectedSegment: Int) {
        router.openMainSearchModule(selectedSegment: selectedSegment)
    }
    
    func handleKitsForCategory(category: Int, transferData trasferData: MainFilterContainerTransferDataProtocol?, filterButton: UIButton) {
        interactor.fetchKitsForCategory(category: category, transferData: trasferData, filterButton: filterButton)
    }
    
    func openKitFolioDetailedModule(kitId: String, ownerId: String) {
        router.openKitFolioDetailedModule(kitId: kitId, ownerId: ownerId, moduleOutput: self)
    }
    
    func openKitsModule(segmentedIndex: Bool, kitId: String, ownerId: String) {
        router.openKitsModule(segmentedIndex: segmentedIndex, kitId: kitId, ownerId: ownerId, moduleOutput: self)
    }
}

// MARK: - MainFilterContainerInteractorOutput

extension MainFilterContainerPresenter: MainFilterContainerInteractorOutput {
    func showAlert(title: String, message: String) {
        view.showAlert(title: title, message: message)
    }
}

// MARK: - MainFilterContainerModuleInput

extension MainFilterContainerPresenter: MainFilterContainerModuleInput {
}

extension MainFilterContainerPresenter: FiltersModuleOutput{
    func kitsWithFilters(filter: Bool) {

    }
}

extension MainFilterContainerPresenter: KitFolioDetailedModuleOutput {
    func updateKitFolio() {
        view.passData(selectedItem: 2)
    }
}

extension MainFilterContainerPresenter: KitsDetailedModuleOutput {
    func updateKits() {
        view.passData(selectedItem: 1)
    }
    func updateKitForSale() {
        view.passData(selectedItem: 0)
    }
}
