//
//  Category.swift
//  KitStop
//
//  Created by Mac on 12/22/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {

    dynamic var number: String = ""
    dynamic var title: String = ""
    dynamic var isSelected = false
    override static func primaryKey() -> String? {
        return "number"
    }
    
}
