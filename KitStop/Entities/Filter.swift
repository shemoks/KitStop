//
//  Filter.swift
//  KitStop
//
//  Created by Mac on 12/16/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//
enum FiltersType {
    case type
    case brand
}

struct Price {

    var minValue: Int = 0
    var maxValue: Int = 100

}

class Filter {

    var typeFilter: [FilterItems] = []
    var brandFilter: [FilterItems] = []
    var priceFilter = Price(minValue: 0, maxValue: 100)

}

class FilterItems {

    var id: Int = 0
    var title: String = ""
    var isSelected: Bool = false
    
}
