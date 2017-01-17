//
//  CreatePostServiceProtocol.swift
//  KitStop
//
//  Created by Mac on 1/10/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation

protocol CreatePostServiceProtocol {

    func getStructureOfCategory(onlyForSale: Bool, idCategory: String, categoryStructure: @escaping ((Post, _ errorCode: Int?) -> ()))
    func savePost()

}
