//
//  KitFolioDetailedPresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import SDWebImage

// MARK: - KitFolioDetailedPresenter

final class KitFolioDetailedPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: KitFolioDetailedViewInput!
    var interactor: KitFolioDetailedInteractorInput!
    var router: KitFolioDetailedRouterInput!
    
    fileprivate var id: String?
    fileprivate var ownerId: String?

}

// MARK: - KitFolioDetailedViewOutput

extension KitFolioDetailedPresenter: KitFolioDetailedViewOutput {

    func checkXib(view: UIView?) {
        if view != nil {
            self.view.addXibOnView(view: view!)
        }
    }
    
    func checkToolBar(view: UIView?) {
        if view != nil {
            self.view.addToolBar(toolBar: view!)
        }
    }
    
    func handleKitData() {
        interactor.fetchKitFrom(id: self.id)
    }
    
    func addImageWithOrientation(imageView: UIImageView, imageUrl: String?, imageHeight: CGFloat) {
        imageView.frame.size.height = imageHeight
        if imageUrl != nil && imageUrl != "" {
            let url = URL.init(string: imageUrl!)
            imageView.sd_setImage(with: url!)
        } else {
            // whats happaned if image does return on server ???
        }
    }
    
    func checkUserInformation(xib: UIView, user: User) {
        if ownerId != nil && !checkUserInRealm(userId: self.ownerId!) {
            (xib as! UserInformationViewController).updateUser(user: user)
        }
    }
    
    func updateData(xib: UIView) -> Bool {
        if checkUserInRealm(userId: ownerId!) {
            (xib as! UserInformationViewController).updateUser(user: nil)
            return true
        }
        return false
    }
    
    func checkUserInRealm(userId: String) -> Bool {
        return User().checkUser(id: userId)
    }
    
    func openChat() {
        router.openChatModule()
    }
}

// MARK: - KitFolioDetailedInteractorOutput

extension KitFolioDetailedPresenter: KitFolioDetailedInteractorOutput {
    func updateProductData(product: Product, user: User?) {
        view.updateProduct(product: product, user: user)
    }
}

// MARK: - KitFolioDetailedModuleInput

extension KitFolioDetailedPresenter: KitFolioDetailedModuleInput {
    func handleKitId(id: String, ownerId: String) {
        self.id = id
        self.ownerId = ownerId
    }
}
