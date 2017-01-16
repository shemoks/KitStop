//
//  MainFilterContainerInteractor.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - MainFilterContainerInteractor
import UIKit

final class MainFilterContainerInteractor {
    
    // MARK: - VIPER stack
    
    weak var presenter: MainFilterContainerInteractorOutput!
    
    fileprivate let dataManager: MainServiceProtocol
    // MARK: -
    
    init(dataManager: MainServiceProtocol) {
        self.dataManager = dataManager
    }
    
    convenience init() {
        self.init(dataManager: MainService())
    }
    
}

// MARK: - MainFilterContainerInteractorInput

extension MainFilterContainerInteractor: MainFilterContainerInteractorInput {
    
    func fetchKitsForCategory(category: Int, transferData: MainFilterContainerTransferDataProtocol?, filterButton: UIButton) {
        apiCallFromCategory(category: category, transferData: transferData, filterButton: filterButton)
    }
    
    func apiCallFromCategory(category: Int, transferData: MainFilterContainerTransferDataProtocol?, filterButton: UIButton) {
        switch category {
        case 0:
            filterButton.isHidden = false
            dataManager.fetchAllKitsForSale(page: 1, completionBlock: {
                kitsForSale, error in
                if error == nil {
                    transferData?.kitItems(transferData: kitsForSale!)
                } else {
                    self.showAlert(error!)
                }
            })
        case 1:
            filterButton.isHidden = false
            dataManager.fetchAllKits(page: 1, completionBlock: {
                kits, error in
                if error == nil {
                    transferData?.kitItems(transferData: kits!)
                } else {
                    self.showAlert(error!)
                }
            })
        case 2:
            filterButton.isHidden = true
            dataManager.fetchAllKitFolio(page: 1, completionBlock: {
                kitFolio, error in
                if error == nil {
                    transferData?.kitItems(transferData: kitFolio!)
                } else {
                    self.showAlert(error!)                }
            })
        default:
            print("error")
        }
    }
    
    func showAlert(_ error: Int) {
        let message = CustomError.init(code: error).description
        self.presenter.showAlert(title: "Error", message: message)
    }
}

