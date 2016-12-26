//
//  AuthService.swift
//  KitStop
//
//  Created by Mac on 12/9/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation
import KeychainAccess

class KeychainService {

    func tokenExists() -> Bool {
        let keychain = Keychain(service: "com.mozidev.KitStop").accessibility(.alwaysThisDeviceOnly)
            .synchronizable(false)

        do {
            let token = try keychain.getString("api_token")
            if token != nil {
                return true
            }
        } catch is Error {
            print("no token")
        }

        return false
    }

    func saveToken(token: String) {
        let keychain = Keychain(service: "com.mozidev.KitStop")
        keychain["api_token"] = token
    }
    
}
