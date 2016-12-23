//
//  Filter.swift
//  KitStop
//
//  Created by Mac on 12/16/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

struct Price {

    var minValue: Int = 0
    var maxValue: Int = 100

}

class Filter {

    var idCategory: Int = 0
    var minPrice: Int = 0
    var maxPrice: Int = 100

}

class FilterItems {

    var id: Int = 0
    var title: String = ""
    var isSelected: Bool = false
    
}
