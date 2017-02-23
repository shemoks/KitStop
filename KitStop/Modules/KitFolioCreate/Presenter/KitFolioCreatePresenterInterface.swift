//
//  KitFolioCreatePresenterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - KitFolioCreateViewOutput

protocol KitFolioCreateViewOutput: class {
    func checkXib(view: UIView?)
    func saveKitFolio(postTitle: String, postDescription: String, smallImage: UIImage?, bigImage: UIImage?)
    func openMainModule()
}

// MARK: - KitFolioCreateInteractorOutput

protocol KitFolioCreateInteractorOutput: class {
    func showAlertWith(title: String, message: String)
    func handleViewWillDisappear()
}

// MARK: - KitFolioCreateModuleInput

protocol KitFolioCreateModuleInput: ModuleInput {
}

// MARK: - KitFolioCreateModuleOutput

protocol KitFolioCreateModuleOutput: ModuleOutput {

}
