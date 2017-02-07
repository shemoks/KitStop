//
//  CalculationForOwner.swift
//  KitStop
//
//  Created by Mac on 2/1/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
class CalculationForOwner: TransportPost {
    var post: Post?

    fileprivate let dataManagerRates: CreateForSaleServiceProtocol
    init(dataManagerRates: CreateForSaleServiceProtocol) {
        self.dataManagerRates = dataManagerRates
    }

    convenience init() {
        self.init(dataManagerRates: CreateForSaleService())
    }
    func getInfo(result: @escaping (RatesModel?) -> ()) {
        dataManagerRates.getRates { [weak self]
            success, error, rates in
            if error == nil {
                result(rates!)
            } else {
                result(nil)
            }
        }

    }

    func returnPost(post: Post) {
        self.post = post
    }

    func getValuesForView(post: Post, rates: RatesModel) -> PriceModel? {
        var resultRate = 0.00
        var stringRate = ""
        var price = "0.00"
        for index in post.salesDetails {
            if index.title == "Package Weight" {
                let value = index.textValue
                for (rate, rateValue) in rates.weight {
                    if rate == value {
                        resultRate = rateValue
                        stringRate = rate
                    }
                }
            }
            if index.title == "Sale price" {
                price = index.textValue
            }
        }
        if price != "" {
            let transactionPrice = Double(price)! * (rates.transactionPercent)/100
            let transactionRatePrice = Double(price)! * (rates.transactionRate)/100
            let kitStopPrice = Double(price)! * (rates.kitStopFee)/100
            let userPrice = Double(price)! - transactionPrice - transactionRatePrice - kitStopPrice - resultRate
            let priceModel = PriceModel(weight: "Shipping UDSP \(stringRate):", weightRate: "$\(String(format: "%.2f", resultRate))" ,startingPrice: "$\(price.formattedDouble(decimalPlaces: 2))", transactionPrice: "$\(String(format: "%.2f", transactionPrice))", transactionRatePrice: "$\(String(format: "%.2f", transactionRatePrice))", kitStopPrice: "$\(String(format: "%.2f", kitStopPrice))", finalPrice: "$\(String(format: "%.2f", userPrice))")
            return priceModel
        }
        return nil
    }

    func calculate (resultValue: @escaping (PriceModel) -> ()) {
        var priceModel = PriceModel(weight: "Shipping:", weightRate: "0.00", startingPrice: "0.00", transactionPrice: "0.00", transactionRatePrice: "0.00", kitStopPrice: "0.00", finalPrice: "0.00")
        self.getInfo { result in
            if result != nil {
                priceModel =  self.getValuesForView(post: self.post!, rates: result!)!
                resultValue(priceModel)
            } else {
                resultValue(priceModel)
            }
        }
    }
}
