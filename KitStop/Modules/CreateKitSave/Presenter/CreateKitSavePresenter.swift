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
    var post: Post?
    var isPrivate:Bool = false
    var date = ""
    var price = ""
    var postId: String?
    var limit:Int?
    var shouldUpdate: Bool = false
    var images = PostImagesModel()

}

// MARK: - CreateKitSaveViewOutput

extension CreateKitSavePresenter: CreateKitSaveViewOutput {
    func setPrivacy(isPrivate: Bool) {
        self.isPrivate = isPrivate
        view.reloadData()
    }
    
    func hasPrivacySet() -> Bool {
        return self.isPrivate
    }
    
    
    func detail(for indexPath: IndexPath) -> KitDetailsModel {
        return details[indexPath.row]
    }
    
    func handleSaveTap() {
        if shouldUpdate {
            interactor.updateKit(price: price, date: date, isPrivate: isPrivate, post: post!, images: self.images)
        } else {
            interactor.saveKit(price: price, date: date, isPrivate: isPrivate, post: post!, images: self.images)
        }
  
    }
    
    func setPrice(value: String) {
            self.price = value
            self.details.last?.contents = "$\(value)"
            view.reloadData()
    }
    
    func setDate(date: String) {
        self.date = date
        details.first?.contents = date
        view.reloadData()
    }
    
    func chosenDate() -> String {
        return self.date
    }
    
    func setLimit() {
        for item in (post?.otherProperty)! {
            if item.title == "Purchase Price" {
                self.limit = item.limit
                break
            }
        }
    }
    
    func priceLimit() -> Int {
        return self.limit!
    }
    
    func setDetails() {
        details.append(KitDetailsModel(header: "Purchase Date", contents: "", placeholder: ""))
        details.append(KitDetailsModel(header: "Purchase Price", contents: "", placeholder: ""))
        
        for item in (post?.otherProperty)! {
            switch item.title {
            case "Purchase Date":
                details.first?.placeholder = item.placeholder
            case "Purchase Price":
                details.last?.placeholder = item.placeholder
            default:
                _ = ""
            }
        }
        
        if shouldUpdate {
            for item in (post?.otherProperty)! {
                switch item.title {
                case "Purchase Date":
                    if !item.textValue.isEmpty {
                             let currentDate = Date(timeIntervalSince1970: Double(item.textValue)!).string(format: "dd/MMM/yyyy")
                        details.first?.contents = currentDate
                   
                        self.date = currentDate
                    }
                case "Purchase Price":
                    if !item.textValue.isEmpty {
                        details.last?.contents = "$\(item.textValue)"
                        self.price = item.textValue
                    }
                default:
                    _ = ""
                }
            }
            self.setPrivacy(isPrivate: (post?.isPrivate)!)
        }

    }
    
    func showAlert() {
        view.showAlert(title: "Error", message: "Set price exceeds maximum value of 1000000")
    }
}

// MARK: - CreateKitSaveInteractorOutput

extension CreateKitSavePresenter: CreateKitSaveInteractorOutput {
    func showAlertWith(title: String, message: String) {
        view.showAlert(title: title, message: message)
    }
    
    func returnToMainModule() {
        view.returnToMainModule()
    }
    
    func openDetailedModule(id: String) {
        
    }
}

// MARK: - CreateKitSaveModuleInput

extension CreateKitSavePresenter: CreateKitSaveModuleInput {
    func setPost(post: Post) {
        self.post = post
    }
    
    func setUpdate(shouldUpdate: Bool) {
        self.shouldUpdate = shouldUpdate
    }

    func setImages(images: PostImagesModel) {
        self.images = images
    }
}
