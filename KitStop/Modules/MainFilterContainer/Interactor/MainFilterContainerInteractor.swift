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
            dataManager.fetchAllKitsForSale(page: (transferData?.page)!, completionBlock: {
                error in
                if error != nil {
                    self.showAlert(error!)
                    self.presenter.stopInfiniteScroll(finishSuccess: false)
                } else {
                    self.presenter.stopInfiniteScroll(finishSuccess: true)
                    self.presenter.removeLoadingIndicatorView()
                    self.presenter.stopRefresh()
                }
            })
        case 1:
            filterButton.isHidden = false
            dataManager.fetchAllKits(page: (transferData?.page)!, completionBlock: {
                error in
                if error != nil {
                    self.showAlert(error!)
                    self.presenter.stopInfiniteScroll(finishSuccess: false)
                } else {
                    self.presenter.stopInfiniteScroll(finishSuccess: true)
                    self.presenter.removeLoadingIndicatorView()
                    self.presenter.stopRefresh()
                }
            })
        case 2:
            filterButton.isHidden = true
            dataManager.fetchAllKitFolio(page: (transferData?.page)!, completionBlock: {
                error in
                if error != nil {
                    self.showAlert(error!)
                    self.presenter.stopInfiniteScroll(finishSuccess: false)
                } else {
                    self.presenter.stopInfiniteScroll(finishSuccess: true)
                    self.presenter.removeLoadingIndicatorView()
                    self.presenter.stopRefresh()
                }
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

