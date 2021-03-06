//
//  MainSearchPresenter.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import UIKit

// MARK: - MainSearchPresenter

final class MainSearchPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: MainSearchViewInput!
    var interactor: MainSearchInteractorInput!
    var router: MainSearchRouterInput!
    
    var kits: [Product]!
    
    var selectedSegment: Int!
    var searhKey = ""

}

// MARK: - MainSearchViewOutput

extension MainSearchPresenter: MainSearchViewOutput {
    func numberOfKits() -> Int {
        if kits != nil {
            return kits.count
        } else {
            return 0
        }
    }
    
    func closeModule() {
        router.closeModule()
    }
    
    func kit(for indexPath: IndexPath) -> Product {
        return kits[indexPath.row]
    }
    
    func setTitle() -> String {
        switch selectedSegment {
        case 0:
            return "Search in 'For Sale' category"
        case 1:
            return "Search in 'Kits' category"
        case 2:
            return "Search in 'KitFolio' category"
        default:
            return "Search"
        }
    }
    
    
    func handleSearchButtonTap(title: String) {
        interactor.commenceSearch(with: title, selectedSegment: selectedSegment)
    }
    
    func refresh() {
        if !searhKey.isEmpty && !searhKey.replacingOccurrences(of: " ", with: "").isEmpty {
            interactor.commenceSearch(with: self.searhKey, selectedSegment: selectedSegment)
        }
    }
    
    func handleItemSelection(for indexPath: IndexPath) {
        let postID = kits[indexPath.row].id
        let ownerID = kits[indexPath.row].owner
        router.openDetailedView(postID: postID, ownerID: ownerID, selectedSegment: self.selectedSegment, moduleOutput: self, returnCase: .search)
    }
}

// MARK: - MainSearchInteractorOutput

extension MainSearchPresenter: MainSearchInteractorOutput {
    func setKits(_ kits: [Product]) {
        self.kits = kits
    }
    
    func reloadData() {
        view.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        view.showAlert(title: title, message: message)
    }
}

// MARK: - MainSearchModuleInput

extension MainSearchPresenter: MainSearchModuleInput {
    func setSegment(selectedSegment: Int) {
        self.selectedSegment = selectedSegment
    }
}

extension MainSearchPresenter: KitsDetailedModuleOutput {
    func updateKits() {
        view.reloadData()
}

    func updateKitForSale() {
        view.reloadData()
    }
}
