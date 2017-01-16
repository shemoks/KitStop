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

    func openPriceModule(post: Post)
    func openList(list: [Other], customListModuleOutput: CustomListModuleOutput)
//  func viewPhoto(images: [UIImage], viewPhotoModuleOutput: ViewPhotoModuleOutput)

}
