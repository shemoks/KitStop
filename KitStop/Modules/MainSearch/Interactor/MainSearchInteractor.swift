//
//  MainSearchInteractor.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - MainSearchInteractor

final class MainSearchInteractor {

    // MARK: - VIPER stack

    weak var presenter: MainSearchInteractorOutput!

    // MARK: -

    fileprivate let dataManager: SearchServiceProtocol
    
    init(dataManager: SearchServiceProtocol) {
        self.dataManager = dataManager
    }
    
    convenience init() {
        self.init(dataManager: SearchService())
    }

}

// MARK: - MainSearchInteractorInput

extension MainSearchInteractor: MainSearchInteractorInput {
    func commenceSearch(with title: String, selectedSegment: Int) {
        switch selectedSegment {
        case 0:
            dataManager.fetchKitsForSaleSearchResults(page: 1, title: title, completion: { [weak self] kits, error, kitsFound in
                if error != nil {
                    self?.presenter.showAlert(title: "Error", message: CustomError.init(code: error!).description)
                } else {
                    self?.presenter.setKits(kits)
                    self?.presenter.reloadData()
                    if !kitsFound {
                        self?.presenter.showAlert(title: "Search Results", message: "Nothing found")
                    }
                }
            })
        case 1:
            dataManager.fetchKitsSearchResults(page: 1, title: title, completion: { [weak self] kits, error, kitsFound in
                if error != nil {
                    self?.presenter.showAlert(title: "Error", message: CustomError.init(code: error!).description)
                } else {
                    self?.presenter.setKits(kits)
                    self?.presenter.reloadData()
                    if !kitsFound {
                        self?.presenter.showAlert(title: "Search Results", message: "Nothing found")
                    }
                }
            })
        default:
            dataManager.fetchKitFolioSearchResults(page: 1, title: title, completion: { [weak self] kits, error, kitsFound in
                if error != nil {
                    self?.presenter.showAlert(title: "Error", message: CustomError.init(code: error!).description)
                } else {
                    self?.presenter.setKits(kits)
                    self?.presenter.reloadData()
                    if !kitsFound {
                        self?.presenter.showAlert(title: "Search Results", message: "Nothing found")
                    }
                }
            })
        }
        
    }
}
