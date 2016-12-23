//
//  MainPresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import UIKit

// MARK: - MainPresenter

final class MainPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!

}

// MARK: - MainViewOutput

extension MainPresenter: MainViewOutput {
    
    func setupAlert() {
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let listForSaleAction = UIAlertAction.init(title: "List for Sale", style: .default, handler: {
            result in
                print("list for sale")
                // you must reference Module Output
                // router.openSecondModule(secondModule: 'Second Module')
        })
        
        let addKitAction = UIAlertAction.init(title: "Add to Kit", style: .default, handler: {
            result in
                // you must reference Module Output
                // router.openSecondModule(secondModule: 'Second Module')
        })
        let postWorkAction = UIAlertAction.init(title: "Post your work", style: .default, handler: {
            result in
                // you must reference Module Output
                // router.openSecondModule(secondModule: 'Second Module')
        })
        let cancel = UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil)
        
        
        alertController.addAction(listForSaleAction)
        alertController.addAction(addKitAction)
        alertController.addAction(postWorkAction)
        alertController.addAction(cancel)
        
        view.presentAlert(alertController: alertController)
    }

}

// MARK: - MainInteractorOutput

extension MainPresenter: MainInteractorOutput {

}

// MARK: - MainModuleInput

extension MainPresenter: MainModuleInput {

}
