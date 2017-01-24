//
//  CreateSaleConfirmPresenter.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import UIKit

// MARK: - CreateSaleConfirmPresenter

final class CreateSaleConfirmPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: CreateSaleConfirmViewInput!
    var interactor: CreateSaleConfirmInteractorInput!
    var router: CreateSaleConfirmRouterInput!
    var details:[ForSaleDetailsModel] = []
    var post: Post!

}

// MARK: - CreateSaleConfirmViewOutput

extension CreateSaleConfirmPresenter: CreateSaleConfirmViewOutput {
    
    func detail(for indexPath: IndexPath) -> ForSaleDetailsModel{
        return details[indexPath.row]
    }
    
    func handleSaveTap() {
        
    }
    
    func setPrice(value: String) {
        details.first!.value = value
    }
    
    func setDetails() {
        details.append(ForSaleDetailsModel(header: "Price", value: "" , isEditable: true, isExpandable: false))
        details.append(ForSaleDetailsModel(header: "Select Conditions", value: "", isEditable: false, isExpandable: true))
        details.append(ForSaleDetailsModel(header: "Package Weight", value: "", isEditable: false, isExpandable: true))
        details.append(ForSaleDetailsModel(header: "Select Card", value: "", isEditable: false, isExpandable: true))
    }
    
  
}

// MARK: - CreateSaleConfirmInteractorOutput

extension CreateSaleConfirmPresenter: CreateSaleConfirmInteractorOutput {

}

// MARK: - CreateSaleConfirmModuleInput

extension CreateSaleConfirmPresenter: CreateSaleConfirmModuleInput {
//    func setPost(with post: Post)
}
