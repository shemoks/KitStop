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
    func setPrice(value: String)
    func setDate(date: TimeInterval)
    func setDetails()
}

// MARK: - CreateKitSaveInteractorOutput

protocol CreateKitSaveInteractorOutput: class {

}

// MARK: - CreateKitSaveModuleInput

protocol CreateKitSaveModuleInput: ModuleInput {

}

// MARK: - CreateKitSaveModuleOutput

protocol CreateKitSaveModuleOutput: ModuleOutput {
    func setPost(post: Post)
}
