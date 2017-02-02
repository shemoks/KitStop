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

    func handleViewDidLoad() {
        // interactor.getPost(forSale: false, idPost: "587cdd8680b4060ff7d68909")
       //view.reloadData()

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
        if self.sectionSale {
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
        return self.sectionSale
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
        interactor.removePost(section: sectionSale, idPost: self.post.id)
    }

    func openEditForSale() {
        router.openEditForSale(post: self.post, oldModel: "forSale")
    }

    func openEditKit() {
        router.openEditKit(post: self.post, oldModel: "kit")
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

}

// MARK: - KitsDetailedInteractorOutput

extension KitsDetailedPresenter: KitsDetailedInteractorOutput {

    func setPost(post: Post) {
        self.post = post
        print(post)
        let urlValue = URL(string: self.post.mainImage)
        if urlValue != nil {
            view.reloadHeader(url: urlValue!, userInfo: post.owner, dateUpdate: Date().dateFrom(string: post.createAt))
        } else {
            //
        }
        let sale = post.salesDetails
        for saleItem in sale {
            if saleItem.title == "Condition" {
                self.post.generalForViewProperty.insert(saleItem, at: 0)
            }
        }
        delegate = calculate
        delegate?.returnPost(post: post)
        calculate.calculate { object in
            self.viewModel = object
            self.view.reloadData()
        self.view.isVisibleTableView(flag: true)
        }
    }

    func showError(title: String, message: String) {
        view.showError(title: title, message: message)
    }

    func showSuccess(title: String, message: String) {
        view.showSuccessAlert(title: title, message: message, action: [UIAlertAction.init(title: "Ok", style: .default, handler: {
            result in
            let moduleOutput = self.moduleOutput as! KitsDetailedModuleOutput
            self.router.closeModule(moduleOutput: moduleOutput, section: self.sectionSale)
        })])

    }

    func setPostForChange(post: Post, oldModel: String) {
        if sectionSale {
            router.openEditKit(post: post, oldModel: oldModel)
        } else {
            router.openEditForSale(post: post, oldModel: oldModel)
        }
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
