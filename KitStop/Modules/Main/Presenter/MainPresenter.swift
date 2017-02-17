//
//  MainPresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import UIKit
import RealmSwift

// MARK: - MainPresenter

final class MainPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!
    var notificationCenter: NotificationToken?
    var preloadMargin = 5
    var lastLoadedPage = 0
}

// MARK: - MainViewOutput

extension MainPresenter: MainViewOutput {
    
    func openModule(identifier: Int) {
        router.openModule(identifier: identifier)
    }
    
    func setupAlert() {
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let listForSaleAction = UIAlertAction.init(title: "List for Sale", style: .default, handler: {
            result in
            self.router.openCategoryModule(secondModuleOutput: self, category:  true, returnCase: .main)
        })
        
        let addKitAction = UIAlertAction.init(title: "Add to Kit", style: .default, handler: {
            result in
            self.router.openCategoryModule(secondModuleOutput: self, category:  false, returnCase: .main)
        })
        let postWorkAction = UIAlertAction.init(title: "Post on KitFolio", style: .default, handler: {
            result in
            self.router.openKitFolioCreateModule(secondModuleOutput: self, returnCase: .main)
        })
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        
        
        alertController.addAction(listForSaleAction)
        alertController.addAction(addKitAction)
        alertController.addAction(postWorkAction)
        alertController.addAction(cancel)
        
        view.presentAlert(alertController: alertController)
    }
    
    func handleKitForSale(page: Int) {
        interactor.handleKitsForSale(page: page)
    }

}

// MARK: - MainInteractorOutput

extension MainPresenter: MainInteractorOutput {
    
    func showLoadingIndicatorView() {
        view.addLoadingIndicatorView()
    }
    
    func removeLoadingIndicatorView() {
        view.removeLoadingIndicatorView()
    }
    
    func finishInfiniteScroll(finishSuccess: Bool) {
        if !finishSuccess {
            view.page -= 1
        }
        view.finishInfiniteScroll()
    }
}

// MARK: - MainModuleInput

extension MainPresenter: MainModuleInput {
    func passData(index: Bool) {
        view.passData(index: index)
    }

    func updateKitFolio() {
        view.passDataToSubmodule()
    }
}

extension MainPresenter: MainModuleOutput {
    func updateKitFolioItems() {
        view.passDataToSubmodule()
    }
    
    func showAlert(title: String, message: String) {
        view.showAlert(title: title, message: message)
    }
}

extension MainPresenter: SelectCategoryModuleOutput {
    
}

extension MainPresenter: KitFolioCreateModuleOutput {
    
}
