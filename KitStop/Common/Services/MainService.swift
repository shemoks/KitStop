//
//  MainService.swift
//  KitStop
//
//  Created by sasha ataman on 27.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit
import Alamofire

class MainService: NSObject, MainServiceProtocol {
    
    fileprivate let manager: ApiManagerProtocol
    
    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }
    
    func fetchAllKits(page: Int, completionBlock: @escaping ([Product]?, _ error: Int?) -> ()) {
        let _ = manager.apiRequest(.getKits(), parameters: ["page" : page as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result {
            case .success(let json):
                if json["success"].boolValue {
                    var kits = [Product]()
                    for kit in json["data"]["docs"] {
                        var kitModel = Product()
                        kitModel.mainImage = kit.1["mainImage"].stringValue
                        kitModel.title = kit.1["title"].stringValue
                        kits.append(kitModel)
                    }
                    kits.reverse()
                    completionBlock(kits, nil)
                } else {
                    completionBlock(nil, response.response?.statusCode)
                }
                print(json)
            case .failure(let error):
                print(error)
                completionBlock(nil, (error as NSError).code)
            }
        })
        
    }
    
    func fetchAllKitFolio(page: Int, completionBlock: @escaping ([Product]?, _ error: Int?) -> ()) {
        let _ = manager.apiRequest(.getKitFolio(), parameters: ["page" : page as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result {
            case .success(let json):
                if json["success"].boolValue {
                    var kits = [Product]()
                    for kit in json["data"]["docs"] {
                        var kitModel = Product()
                        kitModel.mainImage = kit.1["mainImage"].stringValue
                        kitModel.title = kit.1["title"].stringValue
                        kits.append(kitModel)
                    }
                    kits.reverse()
                    completionBlock(kits, nil)
                } else {
                    completionBlock(nil, response.response?.statusCode)
                }
                print(json)
            case .failure(let error):
                print(error)
                completionBlock(nil, (error as NSError).code)
            }
        })
    }
    
    func fetchAllKitsForSale(page: Int,completionBlock: @escaping ([Product]?, _ error: Int?) -> ()) {
        let _ = manager.apiRequest(.getKitsForSale(), parameters: ["page" : page as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result {
            case .success(let json):
                if json["success"].boolValue {
                    var kits = [Product]()
                    for kit in json["data"]["docs"] {
                        var kitModel = Product()
                        var saleDetails = SalesDetails()
                        kitModel.mainImage = kit.1["mainImage"].stringValue
                        kitModel.title = kit.1["title"].stringValue
                        if let price = kit.1["salesDetails"]["price"].double {
                            saleDetails.price = price
                            kitModel.salesDetails = saleDetails
                        }
                        kits.append(kitModel)
                    }
                    kits.reverse()
                    completionBlock(kits, nil)
                } else {
                    completionBlock(nil, response.response?.statusCode)
                }
                print(json)
            case .failure(let error):
                print(error)
                completionBlock(nil, (error as NSError).code)
            }
        })
    }
}
