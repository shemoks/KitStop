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
            presenter.showError(title: "Error", message: "add one photo!")
        } else {
            let validarionResult = ValidationPost().validationBeforeNext(post: post)
            if !validarionResult {
                presenter.showError(title: "Error", message: "missing complite required fields")
                presenter.selectMistakes(post: post)
            } else {
                var i = 0
                for data in post.additionalProperty {
                    if data.metadata {
                        post.additionalProperty.remove(at: i)
                        i += 1
                    }
                }
                i = 0
                for data in post.generalProperty {
                    if data.metadata {
                        post.additionalProperty.remove(at: i)
                        i += 1
                    }
                }
                presenter.setPost(post: post)
            }
        }
    }

}
