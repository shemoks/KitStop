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
    var images: [String?]
    var tags: [String?]
    var metaData: [String:AnyObject] = [:]
    var salesDetails: [String: AnyObject] = [:]
    var isPrivate: Bool = false
}

class ForSaleDetailsModel {
    var header: String?
    var value: String?
    var placeholder: String?
    var isEditable: Bool?
    var isExpandable: Bool?
    
    init(header: String?, value: String?, placeholder: String?, isEditable: Bool?, isExpandable: Bool?) {
        self.header = header
        self.value = value
        self.placeholder = placeholder
        self.isEditable = isEditable
        self.isExpandable = isExpandable
    }
}

struct RatesModel {
    var transactionPercent = 0.0
    var transactionRate = 0.0
    var kitStopFee = 0.0
    var weight: [String:Double] = [:]
}
