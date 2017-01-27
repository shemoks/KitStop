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
    var shouldUpdate = false

    func setReady(isReady: Bool) {
        for item in details {
            item.isReady = true
        }
    }
}

// MARK: - CreateSaleConfirmViewOutput

extension CreateSaleConfirmPresenter: CreateSaleConfirmViewOutput {
    
    func setDetails() {
        let priceDetails = ForSaleDetailsModel(header: "Price", value: "" , placeholder: "", isEditable: true, isExpandable: false, isValid: false, isReady: false)
        let conditionDetails = ForSaleDetailsModel(header: "Select Conditions", value: "", placeholder: "", isEditable: false, isExpandable: true, isValid: false, isReady: false)
        let weightDetails = ForSaleDetailsModel(header: "Package Weight", value: "", placeholder: "", isEditable: false, isExpandable: true, isValid: false, isReady: false)
        
        details.append(priceDetails)
        details.append(conditionDetails)
        details.append(weightDetails)
        
        for item in (post?.salesDetails)! {
            switch item.title {
            case "Sale price":
                details.first?.placeholder = item.placeholder
            case "Condition":
                details[1].placeholder = item.placeholder
            case "Package Weight":
                details.last?.placeholder = item.placeholder
            default:
                _ = ""
            }
        }

        interactor.getRates()
    }
    
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
        if shouldUpdate {
            
        } else {
            
            
            self.setReady(isReady: true)
            
            if price.isEmpty || condition.isEmpty || packageWeight.isEmpty {
                view.reloadData()
                view.showAlert(title: "Missing Fields", message: "Please fill out all required fields")
                self.setReady(isReady: false)
            } else {
               interactor.saveForSaleKit(price: self.price, condition: self.condition, weight: self.packageWeight, post: post!)
            }
            
        }
    }
    
    func setPrice(value: String) {
        self.price = value
        if !value.isEmpty {
            self.details.first?.value = "$\(value)"
            self.details.first?.isValid = true
            self.details.first?.isReady = true
            
        } else {
            self.details.first?.value = ""
            self.details.first?.isValid = false
            self.details.first?.isReady = false
        }
       
        interactor.calculatePrice(price: value, weight: self.packageWeight, rates: self.rates!, completion: {
            priceModel in
            self.view.setPriceLabels(priceModel: priceModel!)
        })

        view.reloadData()
    }
    
    func showAlert() {
        view.showAlert(title: "Error", message: "Set price exceeds maximum value of 1000000")
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
    
    func setRates(rates: RatesModel?) {
        self.rates = rates
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
            details[1].isValid = true
            details[1].isReady = true
        case 2:
            packageWeight = (self.currentData?.textValue)!
            interactor.calculatePrice(price: self.price, weight: self.packageWeight, rates: self.rates!, completion: {
                priceModel in
                self.view.setPriceLabels(priceModel: priceModel!)
            })
            details.last!.value = packageWeight
            details.last!.isValid = true
            details.last!.isValid = true
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
