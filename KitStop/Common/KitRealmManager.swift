//
//  RealmManager.swift
//  KitStop
//
//  Created by sasha ataman on 02.02.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit
import RealmSwift

class KitRealmManager: NSObject {
    
    static var sharedManager = KitRealmManager()
    
    var showCollectionView: Bool = false
    var getType: String = "KitForSale"
    var setType: String {
        get {
            return getType
        }
        set(newValue) {
            getType = newValue
        }
    }
    
    func insertItem(item: KitModel) throws {
        try getRealm().realm?.write {
            getRealm().realm!.add(item, update: true)
            try getRealm().realm!.commitWrite()
        }
    }
    
    
    func removeItemFrom(id: String) throws {
        let item = getRealm().filter("id = %s", id)
        if item.count > 0 {
            try getRealm().realm?.write {
                getRealm().realm?.delete(item)
                try getRealm().realm!.commitWrite()
            }
        }
    }
    
    func getRealm() -> Results<KitModel> {
        let realm = try! Realm()
        let result = realm.objects(KitModel.self)
        return result
    }
    
    func removeAllFromRealm() {
        do {
            try getRealm().realm?.write {
                getRealm().realm?.delete(getRealm())
                try getRealm().realm!.commitWrite()
            }
        } catch (let error) {
            print("\(error)")
        }
    }

}
