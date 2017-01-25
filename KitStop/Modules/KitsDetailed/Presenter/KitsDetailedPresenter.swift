//
//  KitsDetailedPresenter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 18/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - KitsDetailedPresenter

final class KitsDetailedPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: KitsDetailedViewInput!
    var interactor: KitsDetailedInteractorInput!
    var router: KitsDetailedRouterInput!
    var post = ViewPost()
    var ownerId: String = ""
    var sectionSale: Bool = true
    fileprivate var likeStatus = true

}

// MARK: - KitsDetailedViewOutput

extension KitsDetailedPresenter: KitsDetailedViewOutput {

    func openModule(identifier: Int) {
        router.openModule(identifier: identifier)
    }
    func generalProperty(for indexPath: IndexPath) -> ViewProperty {
        let property = self.post.generalProperty[indexPath.row]
        return property
    }

    func additionalProperty(for indexPath: IndexPath) -> ViewProperty {
        let property = self.post.metaData[indexPath.row]
        return property
    }

    func saleProperty(for indexPath: IndexPath) -> ViewProperty {
        let property = self.post.saleData[indexPath.row]
        return property
    }

    func descriptions(for indexPath: IndexPath) -> ViewProperty {
        return self.post.description
    }

    func notes(for indexPath: IndexPath) -> ViewProperty {
        return self.post.notes
    }

    func numberOfGeneralProperties(inSection section: Int) -> Int {
        return post.generalProperty.count
    }

    func numberOfAdditionalProperties(inSection section: Int) -> Int {
        return post.metaData.count
    }

    func numberOfSaleProperties(inSection section: Int) -> Int {
        return post.saleData.count
    }

    func handleViewDidLoad() {
        // interactor.getPost(forSale: false, idPost: "587cdd8680b4060ff7d68909")
        view.reloadData()

    }

    func getTittle() -> String {
        return  self.post.title
    }

    func updateData(xib: UIView) -> Bool {
        if checkUserInRealm(userId: ownerId) {
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

    func numberOfSections() -> Int {
        if self.sectionSale {
            return 4
        } else {
            return 5
        }
    }
    func getPrice() -> String {
        var result = ""
        let price = post.saleData
        for saleItem in price {
            if saleItem.title == "Price" {
                result = saleItem.text
            }
        }
        return result
    }

    func getSection() -> Bool {
        return self.sectionSale
    }

    func getImages() -> [String] {
        var images = [String]()
        for image in post.images {
            images.append(image)
        }
        if images.count == 0 {
              images.append(self.post.mainImage)
        }
        return images
    }

    func changeLike(like: UIButton) {
        if likeStatus {
            like.setImage(UIImage.init(named: "like_active"), for: .normal)
            likeStatus = false
        } else {
            like.setImage(UIImage.init(named: "like"), for: .normal)
            likeStatus = true
        }
    }

    func isPrivatePost() -> Bool {
        print(post)
        return !self.post.isPrivate
    }

}

// MARK: - KitsDetailedInteractorOutput

extension KitsDetailedPresenter: KitsDetailedInteractorOutput {

    func setPost(post: ViewPost) {
        self.post = post
        let urlValue = URL(string: self.post.mainImage)
        if urlValue != nil {
            view.reloadHeader(url: urlValue!, userInfo: post.owner, dateUpdate: Date().dateFrom(string: post.createAt))
        } else {
            //
        }
        view.reloadData()
    }

    func showError(title: String, message: String) {
        view.showError(title: title, message: message)
    }

}

// MARK: - KitsDetailedModuleInput

extension KitsDetailedPresenter: KitsDetailedModuleInput {

    func dataForView(forSale: Bool, idPost: String, idOwner: String?) {
        sectionSale = forSale
        self.ownerId = idOwner!
        interactor.getPost(forSale: forSale, idPost: idPost)
    }
    
}
