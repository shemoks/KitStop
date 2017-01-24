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
    var brandName: String?
    var model: String?
    var serialNumber: String?
    var manufacturerCountry: String?
    var purchaseDate: TimeInterval?
    var purchasePrice: String?
    var buyingPlace: String?
    var category: String = ""
    var userDescription: String?
    var manufacturerDescription: String?
    var notes: String?
    var mainImage: String = ""
    var images: [String?]
    var condition: String?
    var tags: [String?]
    var metaData: [String: AnyObject?]
    var salesDetails: [String: AnyObject]
    var isPrivate: Bool = false
}

struct KitsForSalePricingModel {
    var userPrice: Double?
    var shippingFee: Double?
    var transactionFee: Double?
    var kitStopFee: Double?
    var finalPrice: Double?
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
        self.isEditable = isEditable
        self.isExpandable = isExpandable
    }
}
