//
//  MainInteractor.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - MainInteractor
import FBSDKLoginKit

final class MainInteractor {
    
    // MARK: - VIPER stack
    
    weak var presenter: MainInteractorOutput!
    fileprivate let dataManager: MainServiceProtocol
    // MARK: -
    
    init(dataManager: MainServiceProtocol) {
        self.dataManager = dataManager
    }
    
    convenience init() {
        self.init(dataManager: MainService())
    }
    
    
    func handleKitsForSale(page: Int) {
        presenter.showLoadingIndicatorView()
        removeAllFromRealm()
        dataManager.fetchAllKitsForSale(page: page,filterButton: nil, completionBlock: {
            [weak self] error in
            if error != nil {
                let message = CustomError.init(code: error!).description
                self?.presenter.finishInfiniteScroll(finishSuccess: false)
                self?.presenter.showAlert(title: "Error", message: message)
            } else {
                self?.presenter.finishInfiniteScroll(finishSuccess: true)
                self?.presenter.removeLoadingIndicatorView()
            }
        })
    }
    
    func removeAllFromRealm() {
        KitRealmManager.sharedManager.removeAllFromRealm()
    }
    
}

// MARK: - MainInteractorInput

extension MainInteractor: MainInteractorInput {

}
