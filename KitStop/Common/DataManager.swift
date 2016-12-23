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

class DataManager: NSObject , DataManagerProtocol{
    
    fileprivate let manager: ApiManagerProtocol
    
    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }
    
    func fetchUserInServer(email: String, password: String) {
        let _ = manager.apiRequest(.login(), parameters: ["email" : "test@mail.ru" as AnyObject, "password" : "1111" as AnyObject, "clients" : "111" as AnyObject], headers: nil).apiResponse(completionHandler: {
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
