//
//  FacebookService.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 12/30/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FacebookService {
    fileprivate let manager: ApiManagerProtocol
    
    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }
}

extension FacebookService: FacebookServiceProtocol {
    func authenticateUser(token: String, completion: @escaping (Bool) -> ()) {
        let _ = manager.apiRequest(.fbAuthenticate(), parameters: ["fb_token" : "\(token)" as AnyObject, "clients" : String().getUUID() as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                print(json)
                if let token = json["data"]["token"].string{
                    KeychainService().saveToken(token: token)
                }
                completion(true)
            case .failure(let error):
                print(error)
                completion(false)
            }
        })
    }
}
