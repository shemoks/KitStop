//
//  KitsForSaleRequestBody.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 1/24/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation

struct KitsForSaleRequestBody {
    var title: String = ""
    var brand: String?
    var model: String?
    var serialNumber: String?
    var category: String = ""
    var description: String?
    var notes: String?
    var mainImage: String = ""
    var images: [OrderedImage?]
    var tags: [String?]
    var metaData: [String:AnyObject] = [:]
    var salesDetails: [String: AnyObject] = [:]
    var oldModel = "forSale"
}

class ForSaleDetailsModel {
    var header: String?
    var value: String?
    var placeholder: String?
    var isEditable: Bool?
    var isExpandable: Bool?
    var isValid: Bool?
    var isReady: Bool?
    
    init(header: String?, value: String?, placeholder: String?, isEditable: Bool?, isExpandable: Bool?, isValid: Bool?, isReady: Bool?) {
        self.header = header
        self.value = value
        self.placeholder = placeholder
        self.isEditable = isEditable
        self.isExpandable = isExpandable
        self.isValid = isValid
        self.isReady = isReady
    }
}

struct RatesModel {
    var transactionPercent = 0.0
    var transactionRate = 0.0
    var kitStopFee = 0.0
    var weight: [String:Double] = [:]
}

struct PriceModel {
    var weight = "Shipping:"
    var weightRate = "$0.00"
    var startingPrice = "$0.00"
    var transactionPrice = "$0.00"
    var transactionRatePrice = "$0.00"
    var kitStopPrice = "$0.00"
    var finalPrice = "$0.00" 
}
