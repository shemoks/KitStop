//
//  SignUpService.swift
//  KitStop
//
//  Created by sasha ataman on 24.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit
import Alamofire

class SignUpService: NSObject, SignUpServiceProtocol {
    fileprivate let manager: ApiManagerProtocol
    
    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }
    
    func addNewUser(email: String, password: String, photoUrl: String?, name: String?, surname: String?, completionBlock: @escaping (Bool, _ error: Int?) -> ()) {
        let _ = manager.apiRequest(.signUp(), parameters: ["email" : email as AnyObject, "password" : password as AnyObject, "clients" : String().getUUID() as AnyObject, "photoUrl" : photoUrl as AnyObject, "name" : name as AnyObject, "surname" : surname as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                print(json)
                if json["success"].boolValue {
                    let token = KeychainService()
                    token.saveToken(token: json["data"]["token"].stringValue)
                    completionBlock(true, nil)
                } else {
                    completionBlock(false, response.response?.statusCode)
                }
            case .failure(let error):
                print(error)
                completionBlock(false, (error as NSError).code)
            }
            
        })
    }
}
