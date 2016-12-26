//
//  SignUpUserModel.swift
//  KitStop
//
//  Created by sasha ataman on 24.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit

final class SignUpUserModel: NSObject {
    dynamic var email: String
    dynamic var password: String
    dynamic var photoUrl: String?
    
    init(email: String, password: String, photoUrl: String?) {
        self.email = email
        self.password = password
        self.photoUrl = photoUrl
    }
}
