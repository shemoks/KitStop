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
        let _ = manager.apiRequest(.login(email: "test@mail.ru", password: "1111", clients: "111")).apiResponse(completionHandler: {
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
