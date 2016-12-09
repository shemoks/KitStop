//
//  AuthService.swift
//  KitStop
//
//  Created by Mac on 12/9/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation
import KeychainSwift

class KeychainService {

    func tokenExists() -> Bool {
        let keychain = KeychainSwift()
        return keychain.get("api_token") != nil ? true : false
    }
    
    func saveToken(token: String) {
        let keychain = KeychainSwift()
        keychain.set(token, forKey: "api_token")
    }

}
