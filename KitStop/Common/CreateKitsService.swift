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
    func createKit(kit: CreateKitsRequestBody, completion: @escaping (Bool, Int?) -> ()) {
        let _ = manager.apiRequest(.createKit(), parameters: ["page" : page as AnyObject], headers: nil).apiResponse(completionHandler: {
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
}
