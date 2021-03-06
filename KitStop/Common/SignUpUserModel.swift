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
    dynamic var name: String?
    dynamic var surname: String?
    dynamic var userImage: UIImage?
    
    init(email: String, password: String, userImage: UIImage?, name: String?, surname: String?) {
        self.email = email
        self.password = password
        self.userImage = userImage
        self.name = name
        self.surname = surname
    }
}
