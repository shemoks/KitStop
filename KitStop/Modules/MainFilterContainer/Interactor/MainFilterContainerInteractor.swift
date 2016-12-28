//
//  MainFilterContainerInteractor.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - MainFilterContainerInteractor

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

    func fetchKitsForCategory(category: Int, transferData: MainFilterContainerTransferDataProtocol?) {
        apiCallFromCategory(category: category, transferData: transferData)
    }
    
    func apiCallFromCategory(category: Int, transferData: MainFilterContainerTransferDataProtocol?) {
        switch category {
        case 0:
            dataManager.fetchAllKitsForSale(page: 1, completionBlock: {
                kitsForSale in
                transferData?.kitItems(transferData: kitsForSale)
            })
        case 1:
            dataManager.fetchAllKits(page: 1, completionBlock: {
                kits in
                transferData?.kitItems(transferData: kits)
            })
        case 2:
            dataManager.fetchAllKitFolio(page: 1, completionBlock: {
                kitFolio in
                transferData?.kitItems(transferData: kitFolio)
            })
        default:
            print("error")
        }
    }
}
