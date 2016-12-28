//
//  KitsModel.swift
//  KitStop
//
//  Created by sasha ataman on 27.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit

class KitsModel: NSObject {
    dynamic var id = String()
    dynamic var createdAt = String()
    dynamic var updatedAt = String()
    dynamic var title = String()
    dynamic var category = [String : AnyObject]()
    dynamic var mainImage = String()
    dynamic var owner = String()
    dynamic var v = Int()
    dynamic var isPrivate = Bool()
    dynamic var tags = Array<String>()
    dynamic var images = Array<String>()
    var price: Int?
    
    // if it`s kits for sales, added 'salesDetails': [id, createdAt, updatedAt, price, currency, post, __v]
    dynamic var saleDetailModel = SaleDetailsModel()
}
