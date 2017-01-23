//
//  SearchService.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 1/4/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchService: SearchServiceProtocol {
    
    fileprivate let manager: ApiManagerProtocol
    
    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }
    
    func fetchKitFolioSearchResults(page: Int, title: String, completion: @escaping ([Product], _ error: Int?, Bool) -> ()) {
        let _ = manager.apiRequest(.getKitFolio(), parameters: ["page" : page as AnyObject, "title": title as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result {
            case .success(let json):
                var kits = [Product]()
                for kit in json["data"]["docs"] {
                    var kitModel = Product()
                    kitModel.mainImage = kit.1["mainImage"].stringValue
                    kitModel.title = kit.1["title"].stringValue
                    kitModel.id = kit.1["_id"].stringValue
                    kitModel.owner = kit.1["owner"].stringValue
                    kits.append(kitModel)
                }
                if json["data"]["docs"].count == 0 {
                    completion(kits, nil, false)
                } else {
                    completion(kits, nil, true)
                }
                print(json)
            case .failure(let error):
                completion([Product](), (error as NSError).code, false)
                print(error)
            }
        })
    }
    
    
    func fetchKitsSearchResults(page: Int, title: String, completion: @escaping ([Product], _ error: Int?, _ kitsFound: Bool) -> ()) {
        let _ = manager.apiRequest(.getKits(), parameters: ["page" : page as AnyObject, "title": title as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result {
            case .success(let json):
                var kits = [Product]()
                for kit in json["data"]["docs"] {
                    var kitModel = Product()
                    kitModel.mainImage = kit.1["mainImage"].stringValue
                    kitModel.title = kit.1["title"].stringValue
                    kitModel.id = kit.1["_id"].stringValue
                    kitModel.owner = kit.1["owner"].stringValue
                    kits.append(kitModel)
                }
                if json["data"]["docs"].count == 0 {
                    completion(kits, nil, false)
                } else {
                     completion(kits, nil, true)
                }
                print(json)
            case .failure(let error):
                completion([Product](), (error as NSError).code, false)
                print(error)
            }
        })
    }
    
    func fetchKitsForSaleSearchResults(page: Int, title: String, completion: @escaping ([Product], _ error: Int?, _ kitsFound: Bool) -> ()) {
        let _ = manager.apiRequest(.getKitsForSale(), parameters: ["page" : page as AnyObject, "title": title as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result {
            case .success(let json):
                var kits = [Product]()
                for kit in json["data"]["docs"] {
                    var kitModel = Product()
                    var saleDetails = SalesDetails()
                    kitModel.mainImage = kit.1["mainImage"].stringValue
                    kitModel.title = kit.1["title"].stringValue
                    kitModel.id = kit.1["_id"].stringValue
                    kitModel.owner = kit.1["owner"].stringValue
                    if let price = kit.1["salesDetails"]["price"].double {
                        saleDetails.price = price
                        kitModel.salesDetails = saleDetails
                    }
                    kits.append(kitModel)
                }
                if json["data"]["docs"].count == 0 {
                    completion(kits, nil, false)
                } else {
                    completion(kits, nil, true)
                }
                print(json)
            case .failure(let error):
                completion([Product](), (error as NSError).code, false)
                print(error)
            }
        })
    }

}
