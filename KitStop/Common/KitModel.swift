//
//  KitModel.swift
//  KitStop
//
//  Created by sasha ataman on 02.02.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import RealmSwift

class KitModel: Object {
    
    dynamic var id: String = ""
    dynamic var title: String = ""
    dynamic var mainImage: String = ""
    dynamic var total: Int = 0
    var price = RealmOptional<Double>()
    dynamic var type: String = ""
    dynamic var owner: String = ""
    dynamic var isPrivate: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
