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
    var post = Post()
    var ownerId: String = ""
    var sectionSale: Bool = true
    fileprivate var likeStatus = true
    var numberItem: Int = 0
    var calculate = CalculationForOwner()
    var delegate: TransportPost?
    var viewModel: PriceModel?
    var search: Bool = false
    var caseOf: ReturnCase = .view
    var section: Bool = true

}

// MARK: - KitsDetailedViewOutput

extension KitsDetailedPresenter: KitsDetailedViewOutput {

    func openModule(identifier: Int) {
        router.openModule(identifier: identifier)
    }
    func generalProperty(for indexPath: IndexPath) -> Property {
        let property = self.post.generalForViewProperty[indexPath.row]
        return property
    }

    func additionalProperty(for indexPath: IndexPath) -> Property {
        let property = self.post.additionalForViewProperty[indexPath.row]
        return property
    }

    func saleProperty(for indexPath: IndexPath) -> Property {
        let property = self.post.otherForViewProperty[indexPath.row]
        return property
    }

    func descriptions(for indexPath: IndexPath) -> Property {
        return self.post.description
    }

    func notes(for indexPath: IndexPath) -> Property {
        return self.post.notes
    }

    func numberOfGeneralProperties(inSection section: Int) -> Int {
        return post.generalForViewProperty.count
    }

    func numberOfAdditionalProperties(inSection section: Int) -> Int {
        return post.additionalForViewProperty.count
    }

    func numberOfSaleProperties(inSection section: Int) -> Int {
        return post.otherForViewProperty.count
    }

    func handleViewDidLoad(result: @escaping () -> ()) {
            interactor.getPostForUpdate(forSale: self.section, idPost: post.id) {
                object in
                self.post = object
                self.update()
                result()
            }
    }

    func getTittle() -> String {
        return  self.post.title.textValue
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
        if self.section {
            return 4
        } else {
            return 5
        }
    }
    func getPrice() -> String {
        var result = ""
        let price = post.salesDetails
        for saleItem in price {
            if saleItem.title == "Sale price" {
                if saleItem.units == "USD" {
                    result = "$" + saleItem.textValue
                }
            }
        }
        return result
    }

    func getSection() -> Bool {
        return self.section
    }

    func getImages() -> [String] {
        var images = [String]()
        for image in post.imagesString {
            images.append(image)
        }
        if images.count == 0 {
            images.append(self.post.mainImage)
        }
        return images
    }

    func imageFromUrl() -> [URL] {
        var urlArray = [URL]()
        for url in self.getImages() {
            urlArray.append(URL(string: url)!)
        }
        return urlArray
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

    func removePost() {
        interactor.removePost(section: section, idPost: self.post.id)
    }

    func openEditForSale() {
        router.openEditForSale(post: self.post, oldModel: "forSale", returnCase: self.caseOf)
    }

    func openEditKit() {
        router.openEditKit(post: self.post, oldModel: "Kit", returnCase: self.caseOf)
    }

    func handleKit() {
        //   router.openChatModule()
        interactor.getPostAsKit(idPost: self.post.id)
    }

    func handleKitForSale() {
        //   router.openChatModule()
        interactor.getPostAsForSale(idPost: self.post.id)
    }

    func getPost() -> PriceModel? {
        return viewModel
    }

    func update() {
        let sale = post.salesDetails
        for saleItem in sale {
            if saleItem.title == "Condition" {
                self.post.generalForViewProperty.insert(saleItem, at: 0)
            }
        }
        delegate = calculate
        delegate?.returnPost(post: self.post)
        calculate.calculate { object in
            self.viewModel = object
            if self.view != nil {
                self.view.reloadData()
                let urlValue = URL(string: self.post.mainImage)
                if urlValue != nil {
                    self.view.reloadHeader(url: urlValue!, userInfo: self.post.owner, dateUpdate: Date().dateFrom(string: self.post.createAt))
                } else {
                    //
                }
                self.view.isVisibleTableView(flag: true)
            }
        }
    }

    func beginView() {
        self.view.isVisibleTableView(flag: false)
        update()
    }

    func changeStatus() {

    }

}

// MARK: - KitsDetailedInteractorOutput

extension KitsDetailedPresenter: KitsDetailedInteractorOutput {

    func setPost(post: Post) {
        self.post = post
        print(post)
        update()
    }

    func showError(title: String, message: String) {
        view.showError(title: title, message: message)
    }

    func showSuccess(title: String, message: String) {
        view.showSuccessAlert(title: title, message: message, action: [UIAlertAction.init(title: "Ok", style: .default, handler: {
            result in
            self.router.closeModule(section: self.section)
        })])

    }

    func setPostForChange(post: Post, oldModel: String) {
        if sectionSale {
            router.openEditKit(post: post, oldModel: oldModel, returnCase: self.caseOf)
            section = !section
        } else {
            router.openEditForSale(post: post, oldModel: oldModel, returnCase: self.caseOf)
            section = !section
        }
    }

}

// MARK: - KitsDetailedModuleInput

extension KitsDetailedPresenter: KitsDetailedModuleInput {

    func dataForView(forSale: Bool, idPost: String, idOwner: String?) {
        section = forSale
        sectionSale = forSale
        self.ownerId = idOwner!
        interactor.getPost(forSale: forSale, idPost: idPost)
        
    }
    
    func flagFromSearch(search: Bool) {
        self.search = true
    }
    
    func returnCase(caseOf: ReturnCase) {
        self.caseOf = caseOf
    }
}
