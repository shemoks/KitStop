//
//  CreatePostViewInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - CreatePostViewInput

protocol CreatePostViewInput: class {

   func reloadData()
   func openGallery()
   func showError(title: String, message: String)

}
