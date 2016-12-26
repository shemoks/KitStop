//
//  DataManager.swift
//  KitStop
//
//  Created by sasha ataman on 16.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class LogInService: NSObject , LogInServiceProtocol{
    
    fileprivate let manager: ApiManagerProtocol
    
    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }
    
    func fetchUser(email: String, password: String, result: @escaping (Bool) -> ()) {
        let _ = manager.apiRequest(.login(), parameters: ["email" : email as AnyObject, "password" : password as AnyObject, "clients" : String().getUUID() as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                if json["success"] == "true" {
                    // parse and save data
                    result(true)
                } else {
                    result(false)
                }
            case .failure(let error):
                print(error)
                result(false)
            }
        })
    }
    
}
