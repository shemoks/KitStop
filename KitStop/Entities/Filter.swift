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

    var minValue: Double = 0
    var maxValue: Double = 0

}

class Filter {

    var typeFilter: [FilterItems] = []
    var brandFilter: [FilterItems] = []
    var priceFilter = Price(minValue: 0, maxValue: 0)

}

class FilterItems {

    var id: Int = 0
    var title: String = ""
    var isSelected: Bool = false
    
}
