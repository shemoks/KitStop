//
//  CreateKitsService.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 1/16/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import Alamofire

class CreateKitsService {
    
    fileprivate let manager: ApiManagerProtocol
    
    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }
    
 
}

extension CreateKitsService: CreateKitsServiceProtocol {
    func createKit(kit: CreateKitsRequestBody, completion: @escaping (Bool, Int?, String?) -> ()) {
        let title = kit.title as AnyObject
        let brandName = kit.brandName as AnyObject
        let model = kit.model as AnyObject
        let serialNumber = kit.serialNumber as AnyObject
        let manufacturerCountry = kit.manufacturerCountry as AnyObject
        let purchaseDate = kit.purchaseDate as AnyObject
        let purchasePrice = kit.purchasePrice as AnyObject
        let buyingPlace = kit.buyingPlace as AnyObject
        let category = kit.category as AnyObject
        let userDescription = kit.userDescription as AnyObject
        let manufacturerDescription = kit.manufacturerDescription as AnyObject
        let notes = kit.notes as AnyObject
        let mainImage = kit.mainImage as AnyObject
        let images = kit.images as AnyObject
        let condition = kit.condition as AnyObject
        let tags = kit.tags as AnyObject
        let metaData = kit.metaData as AnyObject
        let isPrivate = kit.isPrivate as AnyObject
        let _ = manager.apiRequest(.createKit(), parameters: ["title" : title, "brandName" : brandName,
                                                              "model":model, "serialNumber": serialNumber,
                                                              "manufacturerCountry": manufacturerCountry,
                                                              "purchaseDate": purchaseDate, "purchasePrice": purchasePrice,
                                                              "buyingPlace": buyingPlace, "category": category,
                                                              "userDescription": userDescription,
                                                              "manufacturerDescription": manufacturerDescription,
                                                              "notes": notes, "mainImage": mainImage,
                                                              "images": images, "condition": condition,
                                                              "tags": tags, "metaData": metaData,
                                                               "isPrivate": isPrivate], headers: nil).apiResponse(completionHandler: {
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
}
