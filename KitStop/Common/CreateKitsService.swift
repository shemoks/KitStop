//
//  CreateKitsService.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 1/16/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CreateKitsService {

    fileprivate let manager: ApiManagerProtocol

    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }


}

extension CreateKitsService: CreateKitsServiceProtocol {
    func createKit(kit: CreateKitsRequestBody, completion: @escaping (Bool, Int?, String?) -> ()) {
        let title = kit.title as AnyObject
        let brandName = kit.brand as AnyObject
        print("BRAND NAME:   \(brandName)")
        let model = kit.model as AnyObject
        let serialNumber = kit.serialNumber as AnyObject
        let purchaseDate = kit.purchaseDate as AnyObject
        let purchasePrice = kit.purchasePrice as AnyObject
        let category = kit.category as AnyObject
        let description = kit.description as AnyObject
        let notes = kit.notes as AnyObject
        let mainImage = kit.mainImage as AnyObject
        var imageDictionary: [[String:AnyObject]] = []
        
        for image in kit.images {
            imageDictionary.append((image?.getDictFormat())!)
        }
        
        let images =  imageDictionary as AnyObject
        print(images)
        let tags = kit.tags as AnyObject
        let metaData = kit.metaData as AnyObject
        let isPrivate = kit.isPrivate as AnyObject
        let _ = manager.apiRequest(.createKit(), parameters: ["title" : title, "brand" : brandName,
                                                              "model":model, "serialNumber": serialNumber,
                                                              "purchaseDate": purchaseDate, "purchasePrice": purchasePrice,
                                                              "category": category,
                                                              "description": description,
                                                              "notes": notes, "mainImage": mainImage,
                                                              "images": images,
                                                              "tags": tags, "metaData": metaData,
                                                              "isPrivate": isPrivate], headers: nil).apiResponse(completionHandler: {
                                                                response in
                                                                switch response.result {
                                                                case .success(let json):
                                                                    if json["success"].boolValue {
                                                                                  print(json)
                                                                        completion(true, nil, json["data"]["_id"].stringValue)
                                                                    } else {
                                                                        completion(false, response.response?.statusCode, nil)
                                                                    }
                                                                    print("KIT WAS SUCCESSFULLY SAVED: \(json)")
                                                                case .failure(let error):
                                                                    print(error)
                                                                    completion(false, (error as NSError).code, nil)
                                                                }
                                                              })
    }
    
    func updateKit(id: String, kit: CreateKitsRequestBody, completion: @escaping (Bool, Int?, String?) -> ()) {
        let title = kit.title as AnyObject
        let brandName = kit.brand as AnyObject
        let model = kit.model as AnyObject
        let serialNumber = kit.serialNumber as AnyObject
        let purchaseDate = kit.purchaseDate as AnyObject
        let purchasePrice = kit.purchasePrice as AnyObject
        let category = kit.category as AnyObject
        let description = kit.description as AnyObject
        let notes = kit.notes as AnyObject
        let mainImage = kit.mainImage as AnyObject
        var imageDictionary: [[String:AnyObject]] = []
        
        for image in kit.images {
            imageDictionary.append((image?.getDictFormat())!)
        }
        
        let images =  imageDictionary as AnyObject
        print(images)
        let tags = kit.tags as AnyObject
        let metaData = kit.metaData as AnyObject
        let isPrivate = kit.isPrivate as AnyObject
        let oldModel = kit.oldModel as AnyObject
        let _ = manager.apiRequest(.updateKit(id: id), parameters: ["title" : title, "brand" : brandName,
                                                              "model":model, "serialNumber": serialNumber,
                                                              "purchaseDate": purchaseDate, "purchasePrice": purchasePrice,
                                                              "category": category,
                                                              "description": description,
                                                              "notes": notes, "mainImage": mainImage,
                                                              "images": images,
                                                              "tags": tags, "metaData": metaData,
                                                              "isPrivate": isPrivate, "oldModel": oldModel], headers: nil).apiResponse(completionHandler: {
                                                                response in
                                                                switch response.result {
                                                                case .success(let json):
                                                                    if json["success"].boolValue {
                                                                        print(json)
                                                                        completion(true, nil, json["data"]["_id"].stringValue)
                                                                    } else {
                                                                        print(response.result.value as Any)
                                                                        completion(false, response.response?.statusCode, nil)
                                                                    }
                                                                case .failure(let error):
                                                                    print(error)
                                                                    completion(false, (error as NSError).code, nil)
                                                                }
                                                              })
    }
}
