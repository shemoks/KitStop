//
//  RestorePasswordService.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 12/30/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation
import Alamofire

class RestorePasswordService {
    fileprivate let manager: ApiManagerProtocol
    
    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }
}

extension RestorePasswordService: RestorePasswordServiceProtocol {
    func requestPasswordRecovery(email: String, completion: @escaping (Bool, _ error: Int?) -> ()) {
        let _ = manager.apiRequest(.forgot(), parameters: ["email" : email as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                print(json)
                if json["success"].bool! {
                    completion(true, nil)
                } else {
                    completion(false, response.response?.statusCode)
                }
            case .failure(let error):
                print(error)
                completion(false, (error as NSError).code)
            }
        })

    }
}
