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
    var isNotMainImage: Bool = false
    var shouldUpdate = false
    var model = PostImagesModel()
    var anyObject = [AnyObject]()
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
        view.reloadData()
    }

    func photoProperty(for indexPath: IndexPath) -> UIImage {
        return self.images[indexPath.row]!
    }

    func numberOfPhoto() -> Int {
        return self.model.toDisplay.count
    }

    func handleFullScreenOpen(index: Int) {
        let images = model.forGallery
        anyObject.removeAll()
        for item in images {
            switch item {
            case .Actual(let image):
                anyObject.append(image)
            case .Remote(let url):
                anyObject.append(url as AnyObject)
            default: break
            }

        }
        view.returnImages(images: anyObject, index: index)

    }

    func setIsNotMainImage() -> Bool {
        return self.isNotMainImage
    }

    func getTittle() -> String {
        return self.screenTitle + self.post.categoryTitle
    }

    func handleNextTap() {
        //        self.post.images = self.images as! [UIImage]
        interactor.getObject(post: self.post, model: model)
    }

    func  isSelectedCell(inSection: Int, for indexPath: IndexPath) {
        switch inSection {
        case 0:
            if  let object = self.generalProperty(for: indexPath).list {
                self.currentData = self.generalProperty(for: indexPath)
                router.openList(list: object, customListModuleOutput: self, name: (self.currentData?.title)!)
            }
        case 1:
            if  let object = self.additionalProperty(for: indexPath).list {
                self.currentData = self.additionalProperty(for: indexPath)
                router.openList(list: object, customListModuleOutput: self, name: (self.currentData?.title)!)
            }
        default:
            _ = [Other]()
        }
    }

    func setMainPhoto(photo: UIImage) {
        self.post.mainImageObject = photo
    }

    func addPhoto(image: UIImage) {
        self.isNotMainImage = true
        self.model.add(image: image)
        view.reloadData()
    }

    func getModelItem(index: Int) -> PostImagesModel.CellImage {
        return self.model.toDisplay[index]
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

    func selectMistakes() {
        view.reloadData()
    }

    func setPost(post: Post, model: PostImagesModel) {
        self.postForPrice = post
        self.model = model
        if isForSale {
            router.openSaveForSaleModule(post: self.postForPrice, images: self.model, shouldUpdate: self.shouldUpdate)
        } else {
            router.openSaveKitModule(post: self.postForPrice, images: self.model, shouldUpdate: self.shouldUpdate)
        }
    }

}

// MARK: - CreatePostModuleInput

extension CreatePostPresenter: CreatePostModuleInput {

    func setUpdate(shouldUpdate: Bool) {
        self.shouldUpdate = shouldUpdate
    }

    func valuesFromCategoryList(forSale: Bool, idCategory: String) {
        if forSale {
            self.isForSale = true
            self.screenTitle = "ForSale / "
        } else {
            self.isForSale = false
            self.screenTitle = "Kits / "
        }
        interactor.getStructure(forSale: forSale, idCategory: idCategory)
    }

    func setKitEdit(post: Post) {
        isForSale = false
        self.screenTitle = "Kits / "
        self.post = post
        for image in post.imagesString {
            let urlValue = URL(string: image)
            self.model.add(url: urlValue!)
        }
        self.isNotMainImage = true
        self.shouldUpdate = true
    }


    func setForSaleEdit(post: Post) {
        isForSale = true
        self.screenTitle = "ForSale / "
        self.post = post
        for image in post.imagesString {
            let url = URL(string: image)
            self.model.add(url: url!)
        }
        self.isNotMainImage = true
        self.shouldUpdate = true
    }

}

extension CreatePostPresenter: CustomListModuleOutput {

    func getData(data: Other) {
        self.currentData?.list?.last?.data = ""
        self.currentData?.isValidate = true
        self.currentData?.textValue = data.name
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

//extension CreatePostPresenter: ViewPhotoModuleOutput {
//
//    func setNewPhoto(images: [UIImage]) {
//        var newImages = [UIImage]()
//        var imagesCount = images.count
//        if imagesCount == 0 {
//            newImages.append(UIImage.init(named: "required")!)
//            imagesCount = newImages.count
//            self.isNotMainImage = false
//        }
//        if imagesCount > 0 && imagesCount < 7 {
//            self.isNotMainImage = true
//            newImages.append(UIImage.init(named: "cameraForSave")!)
//            imagesCount = newImages.count
//        }
//        for _ in imagesCount...5 {
//            newImages.append(UIImage.init(named: "blank1")!)
//        }
//
//        self.currentIndex = imagesCount + self.currentIndex
//        self.post.images = newImages
//        self.images = newImages
//    }
//    
//}



