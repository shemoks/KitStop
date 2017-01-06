//
//  CreateKitFolioService.swift
//  KitStop
//
//  Created by sasha ataman on 05.01.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import Alamofire

class CreateKitFolioService: NSObject, CreateKitFolioServiceProtocol  {
    
    fileprivate let manager: ApiManagerProtocol
    
    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }

    
    func createKitFolioItem(postTitle: String, postDescription: String, mainImageUrl: String, arrayImageUrl: [String], completionBlock: @escaping (Bool, _ error: Int?) -> ()) {
        let _ = manager.apiRequest(.createKitFolio(), parameters: ["title" : postTitle as AnyObject, "description" : postDescription as AnyObject, "mainImage" : mainImageUrl as AnyObject, "images" : arrayImageUrl as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                print(json["success"])
                if json["success"].boolValue {
                    print("success \(json)")
                    completionBlock(true, nil)
                } else {
                    print("error \(json)")
                    completionBlock(false, response.response?.statusCode)
                }
            case .failure(let error):
                print(error)
                completionBlock(false, (error as NSError).code)
            }

        })
    }
}
