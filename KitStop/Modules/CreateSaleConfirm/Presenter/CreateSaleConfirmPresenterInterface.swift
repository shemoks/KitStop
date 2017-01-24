//
//  CreateSaleConfirmPresenterInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import UIKit

// MARK: - CreateSaleConfirmViewOutput

protocol CreateSaleConfirmViewOutput: class {
    func detail(for indexPath: IndexPath) -> ForSaleDetailsModel
    func handleSaveTap()
    func priceLimit() -> Int
    func setPrice(value: String)
    func setLimit()
    func setDetails()
    func showAlert()
}

// MARK: - CreateSaleConfirmInteractorOutput

protocol CreateSaleConfirmInteractorOutput: class {
    func showAlertWith(title: String, message: String)
    func returnToMainModule()
}

// MARK: - CreateSaleConfirmModuleInput

protocol CreateSaleConfirmModuleInput: ModuleInput {
    func setPost(with post: Post)
}

// MARK: - CreateSaleConfirmModuleOutput

protocol CreateSaleConfirmModuleOutput: ModuleOutput {
    func setValue(for indexPath: IndexPath, value: String)
}
