//
//  KitFolioDetailedInteractor.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - KitFolioDetailedInteractor

final class KitFolioDetailedInteractor {

    // MARK: - VIPER stack

    weak var presenter: KitFolioDetailedInteractorOutput!

    // MARK: -
    fileprivate let kitFolioDetailerManager: KitFolioDetailedServiceProtocol?
    
    init(kitFolioDetailerManager: KitFolioDetailedServiceProtocol) {
        self.kitFolioDetailerManager = kitFolioDetailerManager
    }
    
    convenience init() {
        self.init(kitFolioDetailerManager: KitFolioDetailedService())
    }
}

// MARK: - KitFolioDetailedInteractorInput

extension KitFolioDetailedInteractor: KitFolioDetailedInteractorInput {
    func fetchKitFrom(id: String?) {
        kitFolioDetailerManager?.fetchKit(id: id!, completitionBlock: {
            product, user, error in
            if error == nil {
                self.presenter.updateProductData(product: product!, user: user)
            } else {
                // show alert
            }
        })
    }
}
