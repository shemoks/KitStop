//
//  MainPresenterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile
import RealmSwift
import UIKit

// MARK: - MainViewOutput

protocol MainViewOutput: class {
    func setupAlert()
    func handleKitForSale(page :Int)
    func openModule(identifier: Int)
    var notificationCenter: NotificationToken? {get set}
    var preloadMargin: Int {get}
    var lastLoadedPage: Int {get set}
}

// MARK: - MainInteractorOutput

protocol MainInteractorOutput: class {
    func showAlert(title: String, message: String)
    func showLoadingIndicatorView()
    func removeLoadingIndicatorView()
    func finishInfiniteScroll(finishSuccess: Bool)
}

// MARK: - MainModuleInput

protocol MainModuleInput: ModuleInput {

    func passData(index: Bool)
    func updateKitFolio()
    
}

// MARK: - MainModuleOutput

protocol MainModuleOutput: ModuleOutput {
    func updateKitFolioItems()
}
