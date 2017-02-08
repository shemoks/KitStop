//
//  CreateKitsRequestBody.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 1/16/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation

struct CreateKitsRequestBody {
    var title: String = ""
    var brand: String?
    var model: String?
    var serialNumber: String?
    var purchaseDate: TimeInterval?
    var purchasePrice: String?
    var category: String = ""
    var description: String?
    var notes: String?
    var mainImage: String = ""
    var images: [String?]
    var tags: [String?]
    var metaData: [String:AnyObject] = [:]
    var isPrivate: Bool = false
    var oldModel = "Kit"
}
