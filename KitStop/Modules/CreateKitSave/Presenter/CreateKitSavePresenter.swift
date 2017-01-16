//
//  CreateKitSavePresenter.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CreateKitSavePresenter

final class CreateKitSavePresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: CreateKitSaveViewInput!
    var interactor: CreateKitSaveInteractorInput!
    var router: CreateKitSaveRouterInput!
    var details: [KitDetailsModel] = []
    var kit: CreateKitsRequestBody?

}

// MARK: - CreateKitSaveViewOutput

extension CreateKitSavePresenter: CreateKitSaveViewOutput {
    func detail(for indexPath: IndexPath) -> KitDetailsModel {
        return details[indexPath.row]
    }
    
    func handleSaveTap() {
        
    }
    
    func setPrice(value: String) {
       kit?.purchasePrice = value
    }
    
    func setDate(date: TimeInterval) {
        kit?.purchaseDate = date
    }
    
    func setDetails() {
        details.append(KitDetailsModel(header: "", contents: ""))
        details.append(KitDetailsModel(header: "", contents: ""))
    }
}

// MARK: - CreateKitSaveInteractorOutput

extension CreateKitSavePresenter: CreateKitSaveInteractorOutput {

}

// MARK: - CreateKitSaveModuleInput

extension CreateKitSavePresenter: CreateKitSaveModuleInput {

}
