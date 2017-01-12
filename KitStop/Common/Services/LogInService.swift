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
import SwiftyJSON
import KeychainAccess

class LogInService: NSObject , LogInServiceProtocol{
    
    fileprivate let manager: ApiManagerProtocol
    
    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }
    
    func fetchUser(email: String, password: String, result: @escaping (Bool, _ error: Int?,_ json: JSON?) -> ()) {
        let _ = manager.apiRequest(.login(), parameters: ["email" : email as AnyObject, "password" : password as AnyObject, "clients" : String().getUUID() as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                print(json["success"])
                if json["success"].boolValue {
                    let token = KeychainService()
                    token.saveToken(token: "123")
                    print(token.tokenExists())
                    let tokenServ = Keychain()
                    print(try! tokenServ.get("api_token")!)
                    // parse and save data
                    token.saveToken(token: json["data"]["token"].stringValue)
                    print("success \(json)")
                    result(true, nil, json)
                } else {
                    print("error \(json)")
                    result(false, response.response?.statusCode, nil)
                }
            case .failure(let error):
                print(error)
                result(false, (error as NSError).code, nil)
            }
        })
    }
    
}
