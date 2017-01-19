//
//  KitFolioDetailedService.swift
//  KitStop
//
//  Created by sasha ataman on 16.01.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit
import Alamofire

class KitFolioDetailedService: NSObject, KitFolioDetailedServiceProtocol {
    
    fileprivate let manager: ApiManagerProtocol
    
    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }
    
    func fetchKit(id: String, completitionBlock: @escaping (Product?, _ user: User?, _ error: Int?) -> ()) {
        let _ = manager.apiRequest( .kitFolioDetailed(id: id) , parameters: nil, headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                print(json["success"])
                if json["success"].boolValue {
                    var product = Product()
                    product.id = json["data"]["_id"].stringValue
                    product.mainImage = json["data"]["mainImage"].stringValue
                    product.title = json["data"]["title"].stringValue
                    product.description = json["data"]["description"].stringValue
                    product.date = Date().dateFrom(string: json["data"]["updatedAt"].stringValue)
                    let user = User()
                    user.id = json["data"]["owner"]["_id"].stringValue
                    user.avatar = json["data"]["owner"]["photoUrl"].stringValue
                    user.name = json["data"]["owner"]["name"].stringValue
                    user.surname = json["data"]["owner"]["surname"].stringValue
                    completitionBlock(product, user, nil)
                } else {
                    print("error \(json)")
                    completitionBlock(nil, nil, response.response?.statusCode)
                }
            case .failure(let error):
                print(error)
                completitionBlock(nil, nil, (error as NSError).code)
            }

        })
    }
}
