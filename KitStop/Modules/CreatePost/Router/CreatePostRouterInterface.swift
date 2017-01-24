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

    func openSaveForSaleModule(post: Post)
    func openSaveKitModule(post: Post)
    func openList(list: [Other], customListModuleOutput: CustomListModuleOutput, name: String)
//  func viewPhoto(images: [UIImage], viewPhotoModuleOutput: ViewPhotoModuleOutput)
    func openUnderConstruction()

}
