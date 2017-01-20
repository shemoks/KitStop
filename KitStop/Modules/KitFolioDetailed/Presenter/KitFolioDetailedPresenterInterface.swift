//
//  KitFolioDetailedPresenterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - KitFolioDetailedViewOutput

protocol KitFolioDetailedViewOutput: class {
    func checkXib(view: UIView?)
    func handleKitData()
    func addImageWithOrientation(imageView: UIImageView, imageUrl: String?, imageHeight: CGFloat)
    func checkUserInformation(xib: UIView, user: User)
    func updateData(xib: UIView) -> Bool
    func openChat()
    func changeLike(like: UIButton)
    func showActionSheet(image: UIImageView, picker: UIImagePickerController)
    func cropImage(editedImage: UIImage?, originalImage: UIImage?)
    func deletePost()
    func validation(data: [String : String], image: UIImage)
    var product: Product? {get set}
    var imageChange: Bool {get set}
    var imageDeleteStatus: Bool {get set}
}

// MARK: - KitFolioDetailedInteractorOutput

protocol KitFolioDetailedInteractorOutput: class {
    func showErrorAlert(title: String, message: String)
    func showSuccessAlert(title: String, message: String)
    func updateProductData(product: Product, user: User?)
    func updateProduct(product: Product)
}

// MARK: - KitFolioDetailedModuleInput

protocol KitFolioDetailedModuleInput: ModuleInput {
    func handleKitId(id: String, ownerId: String)
}

// MARK: - KitFolioDetailedModuleOutput

protocol KitFolioDetailedModuleOutput: ModuleOutput {

}
