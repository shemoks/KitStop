//
//  CreatePostInteractorInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - CreatePostInteractorInput

protocol CreatePostInteractorInput: class {

   func getStructure(forSale: Bool, idCategory: String)
   func getObject(post: Post)

}
