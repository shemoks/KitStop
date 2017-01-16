//
//  UserModel.swift
//  KitStop
//
//  Created by sasha ataman on 05.01.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import RealmSwift

class User : Object {
    dynamic var id: String?
    dynamic var name: String = ""
    dynamic var surname: String = ""
    dynamic var avatar: String?
    dynamic var country: String?
    dynamic var online: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
       
