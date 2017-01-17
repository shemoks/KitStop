//
//  CreatePostInteractor.swift
//  KitStop
//
//  Created by Shemshur Oksana on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - CreatePostInteractor
import UIKit

final class CreatePostInteractor {

    // MARK: - VIPER stack

    weak var presenter: CreatePostInteractorOutput!

    fileprivate let dataManager: CreatePostServiceProtocol
    // MARK: -

    init(dataManager: CreatePostServiceProtocol) {
        self.dataManager = dataManager
    }

    convenience init() {
        self.init(dataManager: CreatePostService())
    }



    // MARK: -

}

// MARK: - CreatePostInteractorInput

extension CreatePostInteractor: CreatePostInteractorInput {

    func getStructure(forSale: Bool, idCategory: String) {
        dataManager.getStructureOfCategory(onlyForSale: forSale, idCategory: idCategory) {object, error in
            if error == nil {
                self.presenter.setStructure(post: object)
            } else {
                let error = CustomError(code: error!).description
                self.presenter.showError(title: "Error", message: error)
                self.presenter.setStructure(post: Post())
            }
        }
    }

    func getObject(post: Post) {
        if post.images.contains(UIImage.init(named: "required")!) {
            presenter.showError(title: "Error", message: "Please add at least one photo")
        } else {
            let validarionResult = ValidationPost().validationBeforeNext(post: post)
            if !validarionResult {
                presenter.showError(title: "Error", message: "Please fill in the required fields")
                presenter.selectMistakes()
            } else {
                let newPost = Post()
                var newAdditionalProperty = [Property]()
                var newGeneralProperty = [Property]()
                var newImages = [UIImage]()
                for data in post.additionalProperty {
                    if !data.metadata {
                        newAdditionalProperty.append(data)
                    }
                }
                newPost.additionalProperty = newAdditionalProperty
                for data in post.generalProperty {
                    if !data.metadata {
                        newGeneralProperty.append(data)
                    }
                }
                newPost.generalProperty = newGeneralProperty
                newPost.categoryId = post.categoryId
                newPost.categoryTitle = post.categoryTitle
                newPost.description = post.description
                for image in post.images {
                    if image != UIImage.init(named: "blank1") && image != UIImage.init(named: "camera") {
                        newImages.append(image)
                    }
                }
                newPost.images = post.images
                newPost.metadata = post.metadata
                newPost.notes = post.notes
                newPost.salesDetails = post.salesDetails
                presenter.setPost(post: newPost)
            }
        }
    }
    
}
