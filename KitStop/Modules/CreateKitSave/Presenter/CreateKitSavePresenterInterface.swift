//
//  CreateKitSavePresenterInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import UIKit

// MARK: - CreateKitSaveViewOutput

protocol CreateKitSaveViewOutput: class {
    func detail(for indexPath: IndexPath) -> KitDetailsModel
    func handleSaveTap()
    func setDate(date: String)
    func setDetails()
    func setPrivacy(isPrivate:Bool)
    func hasPrivacySet() -> Bool
    func priceLimit() -> Int
    func setPrice(value: String)
    func setLimit()
    func showAlert()
}

// MARK: - CreateKitSaveInteractorOutput

protocol CreateKitSaveInteractorOutput: class {
    func showAlertWith(title: String, message: String)
    func returnToMainModule()
}

// MARK: - CreateKitSaveModuleInput

protocol CreateKitSaveModuleInput: ModuleInput {
    func setPost(post: Post)
    func setUpdate(shouldUpdate: Bool)
    
}

// MARK: - CreateKitSaveModuleOutput

protocol CreateKitSaveModuleOutput: ModuleOutput {
    
}
