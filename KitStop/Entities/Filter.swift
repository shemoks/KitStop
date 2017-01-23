//
//  Filter.swift
//  KitStop
//
//  Created by Mac on 12/16/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//


struct Price {

    var minValue: Int = 0
    var maxValue: Int = 1000000

}

struct PriceString {
    var price: Price
    var minValue: String = ""
    var maxValue: String = ""
}

struct Filter {

    var idCategory: String
    var title: String = ""
    var minPrice: Int = 0
    var maxPrice: Int = 1000000
    var type: Bool = true

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

struct SalesDetails {
    var price: Double? = nil
    var id: String? = nil
}

struct Product {
    var id: String = ""
    var title: String = ""
    var salesDetails: SalesDetails?
    var mainImage: String = ""
    var description: String = ""
    var date: String = ""
    var owner: String = ""
    var imagesArray: [String] = []
}

struct FilterResult {
    var products: [Product]
    var total: Int = 0
    var pages: Int = 0
    var limit: Int = 10
}
