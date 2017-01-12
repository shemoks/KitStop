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
    
    
    func handleKitsForSale() {
        dataManager.fetchAllKitsForSale(page: 1, completionBlock: {
            kitsForSale, error in
            if error == nil {
                self.presenter.updateKits(kits: kitsForSale!)
            } else {
                let message = CustomError.init(code: error!).description
                self.presenter.showAlert(title: "Error", message: message)
            }
        })
    }
    
}

// MARK: - MainInteractorInput

extension MainInteractor: MainInteractorInput {
    func logoutFromFacebook() {
        if FBSDKAccessToken.current() != nil {
            FBSDKLoginManager().logOut()
        }
    }
}
