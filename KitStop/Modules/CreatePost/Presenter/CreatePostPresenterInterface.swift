//
//  CreatePostPresenterInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - CreatePostViewOutput

protocol CreatePostViewOutput: class {
    
    func generalProperty(for indexPath: IndexPath)-> Property
    func additionalProperty(for indexPath: IndexPath)-> Property
    func numberOfGeneralProperties(inSection section: Int) -> Int
    func numberOfAdditionalProperties(inSection section: Int) -> Int
    func handleViewDidLoad()
    func photoProperty(for indexPath: IndexPath) -> UIImage
    func numberOfPhoto() -> Int
    func descriptions(for indexPath: IndexPath)-> Property
    func notes(for indexPath: IndexPath)-> Property
    func getTittle() -> String
    func handleNextTap()
    func isSelectedCell(inSection: Int, for: IndexPath)
    func setMainPhoto(photo: UIImage)
    func setIsNotMainImage() -> Bool
    func handleFullScreenOpen(index: Int)
    func getModelItem(index: Int) -> PostImagesModel.CellImage
    func addPhoto(image: UIImage)
    var anyObject: [AnyObject] {get set}
    func deletePhoto(index: Int)

}

// MARK: - CreatePostInteractorOutput

protocol CreatePostInteractorOutput: class {
    
    func setStructure(post: Post)
    func showError(title: String, message: String)
    func selectMistakes()
    func setPost(post: Post, model: PostImagesModel)

}

// MARK: - CreatePostModuleInput

protocol CreatePostModuleInput: ModuleInput {
    
    func valuesFromCategoryList(forSale: Bool, idCategory: String)
    func setKitEdit(post: Post, oldModel: String)
    func setUpdate(shouldUpdate: Bool)
    func setForSaleEdit(post: Post, oldModel: String)
    func returnCase(caseOf: ReturnCase)

}

// MARK: - CreatePostModuleOutput

protocol CreatePostModuleOutput: ModuleOutput {
    
   func  setPost(post: Post)

}
