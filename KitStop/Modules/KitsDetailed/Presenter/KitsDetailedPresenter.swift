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
    var ownerId = "586261da90e61a383f51d9fe"

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
        interactor.getPost(forSale: false, idPost: "587cdd8680b4060ff7d68909")
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

    func isVisibleTable(isVisible: Bool) {
        view.isVisibleTable(isVisible: isVisible)
    }

}

// MARK: - KitsDetailedModuleInput

extension KitsDetailedPresenter: KitsDetailedModuleInput {

    func dataForView(forSale: Bool, idPost: String, idOwner: String?) {
    //    self.ownerId = idOwner

   //   interactor.getPost(forSale: false, idPost: idPost)

    }

}
