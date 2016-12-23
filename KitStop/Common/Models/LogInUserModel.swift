//
//  LogInUserModel.swift
//  KitStop
//
//  Created by sasha ataman on 12.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit

class LogInUserModel: NSObject {
    dynamic var login = String()
    dynamic var password = String()
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
}
