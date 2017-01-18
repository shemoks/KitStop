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

}

// MARK: - KitsDetailedInteractorOutput

extension KitsDetailedPresenter: KitsDetailedInteractorOutput {

    func setPost(post: ViewPost) {
        self.post = post
        let urlValue = URL.init(string: self.post.mainImage)
        view.reloadHeader(url: urlValue!)
        view.reloadData()
    }

    func showError(title: String, message: String) {
        view.showError(title: title, message: message)
    }

}

// MARK: - KitsDetailedModuleInput

extension KitsDetailedPresenter: KitsDetailedModuleInput {

    func dataForView(forSale: Bool, idPost: String) {

     //   interactor.getPost(forSale: true, idPost: idPost)

    }

}
