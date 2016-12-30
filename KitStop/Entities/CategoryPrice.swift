//
//  CategoryPrice.swift
//  KitStop
//
//  Created by Mac on 12/27/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryPrice: Object {

    dynamic var number: String = ""
    var categoryPrice = Price(minValue: 0, maxValue: 100)
    override static func primaryKey() -> String? {
        return "number"
    }

}
