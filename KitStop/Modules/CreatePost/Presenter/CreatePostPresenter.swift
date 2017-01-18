//
//  CreatePostPresenter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CreatePostPresenter

final class CreatePostPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: CreatePostViewInput!
    var interactor: CreatePostInteractorInput!
    var router: CreatePostRouterInput!
    var post = Post()
    var images = [UIImage.init(named: "required"), UIImage.init(named: "blank1"), UIImage.init(named: "blank1"), UIImage.init(named: "blank1"), UIImage.init(named: "blank1"), UIImage.init(named: "blank1")]
    var currentIndex = -1
    var isForSale: Bool = false
    var currentData: Property?
    var screenTitle: String = "ForSale / "
    var postForPrice = Post()

}

// MARK: - CreatePostViewOutput

extension CreatePostPresenter: CreatePostViewOutput {

    func generalProperty(for indexPath: IndexPath) -> Property {
        let property = self.post.generalProperty[indexPath.row]
        self.currentData = nil
        return property
    }

    func additionalProperty(for indexPath: IndexPath) -> Property {
        let property = self.post.additionalProperty[indexPath.row]
        self.currentData = nil
        return property
    }

    func descriptions(for indexPath: IndexPath) -> Property {
        return self.post.description
    }

    func notes(for indexPath: IndexPath) -> Property {
        return self.post.notes
    }


    func numberOfGeneralProperties(inSection section: Int) -> Int {
        return post.generalProperty.count
    }

    func numberOfAdditionalProperties(inSection section: Int) -> Int {
        return post.additionalProperty.count
    }

    func handleViewDidLoad() {
        interactor.getStructure(forSale: false, idCategory: "5862607de9502e38a059613d")
        view.reloadData()
    }

    func photoProperty(for indexPath: IndexPath) -> UIImage {
        return self.images[indexPath.row]!
    }

    func numberOfPhoto() -> Int {
        return self.images.count
    }

    func handleCollectionCellTap(for indexPath: IndexPath) {
        if indexPath.row > currentIndex {
            view.openGallery()
        } else {
          // router.viewPhoto(images: self.images, viewPhotoModuleOutput: self)
        }
    }

    func setPhoto(photo: UIImage) {
        if currentIndex <= 4 {
            self.currentIndex += 1
            images[self.currentIndex] = photo
            if self.currentIndex + 1 < 5 {
                images[self.currentIndex + 1] = UIImage.init(named: "camera")
            }
            view.reloadData()
        }
    }

    func getTittle() -> String {
        return self.screenTitle + self.post.categoryTitle
    }

    func handleNextTap() {
        self.post.images = self.images as! [UIImage]
        interactor.getObject(post: self.post)
        if isForSale {
            router.openSaveForSaleModule(post: self.postForPrice)
        } else {
            router.openSaveKitModule(post: self.postForPrice)
        }
    }

    func  isSelectedCell(inSection: Int, for indexPath: IndexPath) {
        switch inSection {
        case 0:
            if  let object = self.generalProperty(for: indexPath).list {
                self.currentData = self.generalProperty(for: indexPath)
                router.openList(list: object, customListModuleOutput: self)
            }
        case 1:
            if  let object = self.additionalProperty(for: indexPath).list {
                self.currentData = self.additionalProperty(for: indexPath)
                router.openList(list: object, customListModuleOutput: self)
            }
        default:
            _ = [Other]()
        }
    }

}

// MARK: - CreatePostInteractorOutput

extension CreatePostPresenter: CreatePostInteractorOutput {

    func setStructure(post: Post) {
        self.post = post
        view.reloadData()
    }

    func showError(title: String, message: String) {
        view.showError(title: title, message: message)
    }

    func selectMistakes(post: Post) {
        view.reloadData()
    }

    func setPost(post: Post) {
        self.postForPrice = post
    }

}

// MARK: - CreatePostModuleInput

extension CreatePostPresenter: CreatePostModuleInput {


    func valuesFromCategoryList(forSale: Bool, idCategory: String) {
        if forSale {
            self.isForSale = true
            self.screenTitle = "ForSale / "
        } else {
            self.isForSale = false
            self.screenTitle = "Kits / "
        }
        interactor.getStructure(forSale: true, idCategory: idCategory)
    }

}

extension CreatePostPresenter: CustomListModuleOutput {

    func getData(data: Other) {
        self.currentData?.list?.last?.data = ""
        self.currentData?.currentData = data.name
        self.currentData?.textValue = data.name
        view.reloadData()
    }

    func getDataWithInput(data: Other) {
        self.currentData?.currentData = "Other: " + (currentData?.list?.last?.data)!
        self.currentData?.textValue = "Other: " + (currentData?.list?.last?.data)!
        view.reloadData()
    }
}

//extension CreatePostPresenter: ViewPhotoModuleOutput {
//
//    func setNewPhoto(images: [UIImage]) {
//        self.images = images
//    }
//
//}



