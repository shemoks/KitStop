//
//  LogInDataManager.swift
//  KitStop
//
//  Created by sasha ataman on 05.01.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class LogInDataManager: NSObject, LogInDataManagerProtocol {
    
    let realm = try! Realm()
    
    func saveUserData(json: JSON) {
        let userJson = json["data"]["user"]
        let user = User()
        user.id = userJson["_id"].stringValue
        user.name = userJson["name"].stringValue
        user.surname = userJson["surname"].stringValue
        user.avatar = userJson["photoUrl"].stringValue
        user.country = "USA"
        user.online = true
        try! realm.write {
            realm.add(user, update: true)
        }
    }
    
    func getUserFromRealm() -> User? {
        let user = realm.objects(User.self).filter("online = %s", true).first
        return user
    }
    
}
