//
//  CreatePostRouterInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - CreatePostRouterInput
import UIKit

protocol CreatePostRouterInput: class {

    func openSaveForSaleModule(post: Post, images: PostImagesModel, shouldUpdate: Bool, oldModel: String)
    func openSaveKitModule(post: Post, images: PostImagesModel, shouldUpdate: Bool, oldModel: String)
    func openList(list: [Other], customListModuleOutput: CustomListModuleOutput, name: String)
//  func viewPhoto(index: Int, images: [UIImage], isEdit: Bool, viewPhotoModuleOutput: ViewPhotoModuleOutput)
    func openUnderConstruction()

}
