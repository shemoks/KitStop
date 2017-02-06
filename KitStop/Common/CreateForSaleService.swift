//
//  CreateForSaleService.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 1/24/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CreateForSaleService {
    
    fileprivate let manager: ApiManagerProtocol
    
    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }
    
    
}

extension CreateForSaleService: CreateForSaleServiceProtocol {
    func createKit(kit: KitsForSaleRequestBody, completion: @escaping (Bool, Int?, String?) -> ()) {
        let title = kit.title as AnyObject
        let brand = kit.brand as AnyObject
        let model = kit.model as AnyObject
        let serialNumber = kit.serialNumber as AnyObject
        let category = kit.category as AnyObject
        let description = kit.description as AnyObject
        let notes = kit.notes as AnyObject
        let mainImage = kit.mainImage as AnyObject
        let images = kit.images as AnyObject
        let tags = kit.tags as AnyObject
        let metaData = kit.metaData as AnyObject
        let salesDetails = kit.salesDetails as AnyObject
        let _ = manager.apiRequest(.createKitForSale(), parameters: ["title" : title, "brand" : brand,
                                                              "model":model, "serialNumber": serialNumber,
                                                              "category": category,
                                                              "description": description,
                                                              "notes": notes, "mainImage": mainImage,
                                                              "images": images,
                                                              "tags": tags, "metaData": metaData,
                                                              "salesDetails": salesDetails
                                                              ], headers: nil).apiResponse(completionHandler: {
                                                                response in
                                                                switch response.result {
                                                                case .success(let json):
                                                                    if json["success"].boolValue {
                                                                        completion(true, nil, json["data"]["_id"].stringValue)
                                                                    } else {
                                                                        completion(false, response.response?.statusCode, nil)
                                                                    }
                                                                    print(json)
                                                                case .failure(let error):
                                                                    print(error)
                                                                    completion(false, (error as NSError).code, nil)
                                                                }
                                                              })
    }
    
    func updateKit(id: String, kit: KitsForSaleRequestBody, completion: @escaping (Bool, Int?, String?) -> ()) {
        let title = kit.title as AnyObject
        let brand = kit.brand as AnyObject
        let model = kit.model as AnyObject
        let serialNumber = kit.serialNumber as AnyObject
        let category = kit.category as AnyObject
        let description = kit.description as AnyObject
        let notes = kit.notes as AnyObject
        let mainImage = kit.mainImage as AnyObject
        let images = kit.images as AnyObject
        let tags = kit.tags as AnyObject
        let metaData = kit.metaData as AnyObject
        let salesDetails = kit.salesDetails as AnyObject
        let oldModel = kit.oldModel as AnyObject
        let _ = manager.apiRequest(.updateKitForSale(id: id), parameters: ["title" : title, "brand" : brand,
                                                                     "model":model, "serialNumber": serialNumber,
                                                                     "category": category,
                                                                     "description": description,
                                                                     "notes": notes, "mainImage": mainImage,
                                                                     "images": images,
                                                                     "tags": tags, "metaData": metaData,
                                                                     "salesDetails": salesDetails, "oldModel": oldModel
            ], headers: nil).apiResponse(completionHandler: {
                response in
                switch response.result {
                case .success(let json):
                    if json["success"].boolValue {
                        completion(true, nil, json["data"]["_id"].stringValue)
                    } else {
                        completion(false, response.response?.statusCode, nil)
                    }
                    print(json)
                    print(String(data: (response.request?.httpBody)!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)))
                case .failure(let error):
                    print(error)
                    completion(false, (error as NSError).code, nil)
                }
            })
    }
    
    func getRates(completion: @escaping (Bool, _ error: Int?, _ rates: RatesModel?) -> ()) {
        let _ = manager.apiRequest(.rates()).apiResponse(completionHandler: {
            response in
            switch response.result {
            case .success(let json):
                if json["success"].boolValue {
                    let transactionPercent = json["data"]["transactionPercent"].doubleValue
                    let transactionRate = json["data"]["transactionRate"].doubleValue
                    let kitStopFee = json["data"]["kitStopFee"].doubleValue
                    var weight: [String:Double] = [:]
                    
                    for (key, item) in json["data"]["weight"] {
                        weight["\(key)"] = item.doubleValue
                    }
                    
                    let rates = RatesModel(transactionPercent: transactionPercent, transactionRate: transactionRate, kitStopFee: kitStopFee, weight: weight)
                    
                    completion(true, nil, rates)
                    
                } else {
                    completion(false, response.response?.statusCode, nil)
                }
            case .failure(let error):
                print(error)
                completion(false, (error as NSError).code, nil)
            }
        })
    }
}
