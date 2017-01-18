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
    func checkToolBar(view: UIView?)
    func handleKitData()
    func addImageWithOrientation(imageView: UIImageView, imageUrl: String?, imageHeight: CGFloat)
    func checkUserInformation(xib: UIView, user: User)
    func updateData(xib: UIView) -> Bool
    func openChat()
}

// MARK: - KitFolioDetailedInteractorOutput

protocol KitFolioDetailedInteractorOutput: class {
    func updateProductData(product: Product, user: User?)
}

// MARK: - KitFolioDetailedModuleInput

protocol KitFolioDetailedModuleInput: ModuleInput {
    func handleKitId(id: String, ownerId: String)
}

// MARK: - KitFolioDetailedModuleOutput

protocol KitFolioDetailedModuleOutput: ModuleOutput {

}
