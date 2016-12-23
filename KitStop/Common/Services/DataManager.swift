//
//  DataManager.swift
//  KitStop
//
//  Created by sasha ataman on 16.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit
import Alamofire

class DataManager: NSObject {
    
    static let sharedInstance = DataManager()
    
    func fetchUserInServer(email: String, password: String) {
        let parameters = ["email" : "test2345@gmail.com",
                          "password" : "6a082c618a8ec2a36f43e48e6de3452b30dc9a063f11",
                          "clients" : "111"]
        Alamofire.request("https://34.194.202.148:8443/api/v1/authenticate", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON(completionHandler: {
                response in
                if response.result.isSuccess {
                    print(response.result.value)
                }
                if response.result.isFailure {
                    print("error \(response.result.error)")
                }
            })
    }
}
