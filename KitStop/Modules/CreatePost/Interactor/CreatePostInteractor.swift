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

}

// MARK: - CreatePostInteractorInput

extension CreatePostInteractor: CreatePostInteractorInput {

    func getStructure(forSale: Bool, idCategory: String) {
        dataManager.getStructureOfCategory(onlyForSale: forSale, idCategory: idCategory) { [weak self] object, error in
            if error == nil {
                self?.presenter.setStructure(post: object)
            } else {
                let error = CustomError(code: error!).description
                self?.presenter.showError(title: "Error", message: error)
                self?.presenter.setStructure(post: Post())
            }
        }
    }

    func getObject(post: Post, model: PostImagesModel) {
        if post.mainImage == "" {
            presenter.showError(title: "Warning", message: "Please add at least one photo")
        } else {
            let validarionResult = ValidationPost().validationBeforeNext(post: post)
            if !validarionResult {
                presenter.showError(title: "Warning", message: "Please fill in the required fields")
                presenter.selectMistakes()
            } else {
                let newPost = Post()
                var newAdditionalProperty = [Property]()
                var newGeneralProperty = [Property]()
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
                newPost.id = post.id
                newPost.categoryId = post.categoryId
                newPost.categoryTitle = post.categoryTitle
                newPost.description = post.description
                newPost.metadata = post.metadata
                newPost.notes = post.notes
                newPost.salesDetails = post.salesDetails
                newPost.owner = post.owner
                newPost.mainImageObject = post.mainImageObject
                newPost.otherProperty = post.otherProperty
                newPost.mainImageObject = post.mainImageObject
                newPost.isPrivate = post.isPrivate
                presenter.setPost(post: newPost, model: model)
            }
        }
    }
    
}
