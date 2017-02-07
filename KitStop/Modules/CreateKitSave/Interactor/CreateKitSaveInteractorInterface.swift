//
//  CreateKitSaveInteractorInterface.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - CreateKitSaveInteractorInput

protocol CreateKitSaveInteractorInput: class {
    func saveKit(price: String?, date: String?, isPrivate:Bool, post:Post, images: PostImagesModel)
    func updateKit(price: String?, date: String?, isPrivate:Bool, post:Post, images: PostImagesModel, oldModel: String)
}
