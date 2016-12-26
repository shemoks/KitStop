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
    
    func addNewUser(email: String, password: String, photoUrl: String?) {
        let _ = manager.apiRequest(.signUp(), parameters: ["email" : email as AnyObject, "password" : password as AnyObject, "clients" : String().getUUID() as AnyObject, "photo_url" : photoUrl as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                print(json)
            case .failure(let error):
                print(error)
            }

        })
    }
}
