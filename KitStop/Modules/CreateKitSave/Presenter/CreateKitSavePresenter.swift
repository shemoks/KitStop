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
    var date = "Not Set"
    var price = "Not Set"
    var postId: String?
    var limit:Int?

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
        interactor.saveKit(price: price, date: date, isPrivate: isPrivate, post: post!)
    }
    
    func setPrice(value: String) {
        if !value.isEmpty || (value.rangeOfCharacter(from: CharacterSet.whitespaces) == nil) {
            self.price = value
            self.details.last?.contents = "$\(value)"
            view.reloadData()
        }
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
        self.limit = post?.salesDetails[1].limit
    }
    
    func priceLimit() -> Int {
        return self.limit!
    }
    
    func setDetails() {
        details.append(KitDetailsModel(header: "Purchase Date", contents: "", placeholder: "Not Set"))
        details.append(KitDetailsModel(header: "Purchase Price", contents: "", placeholder: "Enter value"))
        
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
}