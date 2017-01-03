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
    
    func fetchAllKits(page: Int, completionBlock: @escaping ([Product]) -> ()) {
        let _ = manager.apiRequest(.getKits(), parameters: ["page" : page as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result {
            case .success(let json):
                var kits = [Product]()
                for kit in json["data"]["docs"] {
                    var kitModel = Product()
                    kitModel.mainImage = kit.1["mainImage"].stringValue
                    kitModel.title = kit.1["title"].stringValue
                    kits.append(kitModel)
                }
                completionBlock(kits)
                print(json)
            case .failure(let error):
                print(error)
            }
        })

    }
    
    func fetchAllKitFolio(page: Int, completionBlock: @escaping ([Product]) -> ()) {
        let _ = manager.apiRequest(.getKitFolio(), parameters: ["page" : page as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result {
            case .success(let json):
                var kits = [Product]()
                for kit in json["data"]["docs"] {
                    var kitModel = Product()
                    kitModel.mainImage = kit.1["mainImage"].stringValue
                    kitModel.title = kit.1["title"].stringValue
                    kits.append(kitModel)
                }
                completionBlock(kits)
                print(json)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchAllKitsForSale(page: Int,completionBlock: @escaping ([Product]) -> ()) {
        let _ = manager.apiRequest(.getKitsForSale(), parameters: ["page" : page as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result {
            case .success(let json):
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
                completionBlock(kits)
                print(json)
            case .failure(let error):
                print(error)
            }
        })
    }
}