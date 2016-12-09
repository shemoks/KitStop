//
//  AuthService.swift
//  KitStop
//
//  Created by Mac on 12/9/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation
import KeychainSwift

class AuthService {

 func verifyAutorization() -> Bool {
        let keychain = KeychainSwift()
        if keychain.get("my key") != nil {
            return true
        }
        return false
    }

}
