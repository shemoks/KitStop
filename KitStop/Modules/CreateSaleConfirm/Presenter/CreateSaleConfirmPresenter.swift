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
    var post: Post?
    var isPrivate:Bool = false
    var price = ""
    var condition = ""
    var packageWeight = ""
    var limit: Int?

}

// MARK: - CreateSaleConfirmViewOutput

extension CreateSaleConfirmPresenter: CreateSaleConfirmViewOutput {
    
    func setLimit() {
        self.limit = post?.salesDetails[1].limit
    }
    
    func priceLimit() -> Int {
        return self.limit!
    }
    
    func detail(for indexPath: IndexPath) -> ForSaleDetailsModel{
        return details[indexPath.row]
    }
    
    func handleSaveTap() {
        
    }
    
    func setPrice(value: String) {
        details.first!.value = value
    }
    
    func showAlert() {
        view.showAlert(title: "Error", message: "Set price exceeds maximum value of 1000000")
    }
    
    func setDetails() {
        details.append(ForSaleDetailsModel(header: "Price", value: "" , placeholder: post?.salesDetails[1].textValue, isEditable: true, isExpandable: false))
        details.append(ForSaleDetailsModel(header: "Select Conditions", value: "", placeholder: post?.salesDetails.first!.textValue, isEditable: false, isExpandable: true))
        details.append(ForSaleDetailsModel(header: "Package Weight", value: "", placeholder: post?.salesDetails.last!.textValue, isEditable: false, isExpandable: true))
    }
    
  
}

// MARK: - CreateSaleConfirmInteractorOutput

extension CreateSaleConfirmPresenter: CreateSaleConfirmInteractorOutput {
    func showAlertWith(title: String, message: String) {
        view.showAlert(title: title, message: message)
    }
    
    func returnToMainModule() {
        view.returnToMainModule()
    }
}

// MARK: - CreateSaleConfirmModuleInput

extension CreateSaleConfirmPresenter: CreateSaleConfirmModuleInput {
    func setPost(with post: Post) {
        self.post = post
    }
}
