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
    
    func fetchKitFolioSearchResults(page: Int, title: String, completion: @escaping ([Product]) -> ()) {
        let _ = manager.apiRequest(.getKitFolio(), parameters: ["page" : page as AnyObject, "title": title as AnyObject], headers: nil).apiResponse(completionHandler: {
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
                completion(kits)
                print(json)
            case .failure(let error):
                print(error)
            }
        })
        
    }
    
    func fetchKitsSearchResults(page: Int, title: String, completion: @escaping ([Product]) -> ()) {
        let _ = manager.apiRequest(.getKits(), parameters: ["page" : page as AnyObject, "title": title as AnyObject], headers: nil).apiResponse(completionHandler: {
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
                completion(kits)
                print(json)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchKitsForSaleSearchResults(page: Int, title: String, completion: @escaping ([Product]) -> ()) {
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
                    if let price = kit.1["salesDetails"]["price"].double {
                        saleDetails.price = price
                        kitModel.salesDetails = saleDetails
                    }
                    kits.append(kitModel)
                }
                completion(kits)
                print(json)
            case .failure(let error):
                print(error)
            }
        })
    }

    
    
}
