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

struct Filter {

    var idCategory: Int = 0
    var title: String = ""
    var minPrice: Int = 0
    var maxPrice: Int = 100

}


enum NetworkResult {
    case Category(value: [Category])
    case CategoryPrice(value: [CategoryPrice])
    case Error(error: Error)
}

struct NetworkObject {
    var data: NetworkResult
    var error: NetworkResult
}

struct product {
    var id: String = ""
    var title: String = ""
    var price: String = ""
    var image: String = ""
}
