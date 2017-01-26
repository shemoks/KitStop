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
    var currentData: Property?
    var isPrivate:Bool = false
    var price = ""
    var condition = ""
    var packageWeight = ""
    var limit: Int?
    var currentIndex: Int?
    var rates: RatesModel?

}

// MARK: - CreateSaleConfirmViewOutput

extension CreateSaleConfirmPresenter: CreateSaleConfirmViewOutput {
    
    func handleCellSelect(for indexPath: IndexPath) {
        
        switch indexPath.row {
        case 1:
            if  let object = self.post?.salesDetails.first!.list {
                self.currentData = self.post?.salesDetails.first!
                self.currentIndex = indexPath.row
                router.openList(list: object, customListModuleOutput: self, name: (self.currentData?.title)!)
            }
        case 2:
            if  let object = self.post?.salesDetails.last!.list {
                self.currentData = self.post?.salesDetails.last!
                self.currentIndex = indexPath.row
                router.openList(list: object, customListModuleOutput: self, name: (self.currentData?.title)!)
            }
        default:
            _ = [Other]()
        }
    }
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
        interactor.saveForSaleKit(price: self.price, condition: self.condition, weight: self.packageWeight, isPrivate: isPrivate, post: post!)
    }
    
    func setPrice(value: String) {
        self.price = value
        self.details[1].value = "$\(value)"
        view.reloadData()
    }
    
    func showAlert() {
        view.showAlert(title: "Error", message: "Set price exceeds maximum value of 1000000")
    }
    
    func setDetails() {
        let priceDetails = ForSaleDetailsModel(header: "Price", value: "" , placeholder: post?.salesDetails[1].placeholder!, isEditable: true, isExpandable: false)
        let conditionDetails = ForSaleDetailsModel(header: "Select Conditions", value: "", placeholder: post?.salesDetails.first!.placeholder, isEditable: false, isExpandable: true)
        let weightDetails = ForSaleDetailsModel(header: "Package Weight", value: "", placeholder: post?.salesDetails.last!.placeholder, isEditable: false, isExpandable: true)
        details.append(priceDetails)
        details.append(conditionDetails)
        details.append(weightDetails)
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

extension CreateSaleConfirmPresenter: CustomListModuleOutput {
    
    func getData(data: Other) {
        self.currentData?.list?.last?.data = ""
        self.currentData?.isValidate = true
        self.currentData?.textValue = data.name
        switch self.currentIndex! {
        case 1:
            condition = (self.currentData?.textValue)!
            details[1].value = condition
        case 2:
            packageWeight = (self.currentData?.textValue)!
            details.last!.value = packageWeight
        default:
            print()
        }
        view.reloadData()
    }
    
    func getDataWithInput(data: Other) {
        if currentData?.list?.last?.data == "" {
            self.currentData?.isValidate = true
            self.currentData?.textValue = "Other"
            view.reloadData()
        } else {
            self.currentData?.isValidate = true
            self.currentData?.textValue = "Other: " + (currentData?.list?.last?.data)!
            view.reloadData()
        }
    }
}
