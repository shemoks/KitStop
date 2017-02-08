//
//  FilterModel.swift
//  KitStop
//
//  Created by Mac on 1/23/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import RealmSwift

class FilterModel: Object {

    dynamic var number: String = ""
    dynamic var title: String = "All categories"
    dynamic var minValue: Int = 0
    dynamic var maxValue: Int = 1000000000
    var section: Bool = true
}

class CurrentFilter {
    dynamic var number: String = ""
    dynamic var title: String = "All categories"
    dynamic var minValue: Int = 0
    dynamic var maxValue: Int = 1000000000
    var section: Bool = true
}
