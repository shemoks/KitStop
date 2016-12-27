//
//  DataManager.swift
//  KitStop
//
//  Created by sasha ataman on 16.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import RealmSwift

class CategoryManager: NSObject, CategoryManagerProtocol {

    fileprivate let manager: ApiManagerProtocol
    var notificationToken: NotificationToken!
    let realm = try! Realm()

    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }

    func categoryFromServer(arrayOfCategories: @escaping (([Category]) -> ())) {
        let _ = manager.apiRequest(.categories(), parameters: [:], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                print(json)
                if json["error"] == nil {
                    let categories = json["data"]
                    for category in categories {
                        let newCategory = Category()
                        newCategory.number = category.1["_id"].stringValue
                        newCategory.isSelected = false
                        newCategory.title = category.1["title"].stringValue
                        self.saveInRealm(category: newCategory)
                        self.notificationToken = self.realm.addNotificationBlock { _ in
                           arrayOfCategories(self.getCategories())
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        })
    }

    func getProducts(filter: Filter) {
        let _ = manager.apiRequest(.filter(), parameters: [:], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                print(json)
            case .failure(let error):
                print(error)
            }
        })
    }

    func saveInRealm(category: Category) {
        try! realm.write {
            realm.add(category, update: true)
        }
    }

    func getCategories() -> [Category] {
        let categories = realm.objects(Category.self)
        return Array(categories)
    }

    func changeCategories(categories: [Category], category: Category) -> [Category] {
        var newCategories = [Category]()
        for newCategory in categories {
            try! realm.write {
                newCategory.isSelected = false
                if newCategory.number == category.number {
                    newCategory.isSelected = true
                }
            }
            newCategories.append(newCategory)
        }
        return newCategories
    }

    func clearAll(categories: [Category]) -> [Category] {
        var newCategories = [Category]()
        for newCategory in categories {
            try! realm.write {
                newCategory.isSelected = false
            }
            newCategories.append(newCategory)
        }
        return newCategories
    }

    func getPrice(category: Category, result: @escaping ((CategoryPrice) -> ())) {
        let _ = manager.apiRequest(.price(), parameters: ["category": category.number as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                print(json)
                if json["success"] == true {
                    var price = Price(minValue: 0, maxValue: 100)
                    let newPrice = CategoryPrice()
                    newPrice.number = category.number
                    let priceValue = json["data"]
                    price.maxValue = Int(priceValue["max"].stringValue)!
                    price.minValue = Int(priceValue["min"].stringValue)!
                    newPrice.categoryPrice = price
                    self.notificationToken = self.realm.addNotificationBlock { _ in
                        self.savePrice(price: newPrice)
                    }
                    result(newPrice)
                } else {
                }
            case .failure(let error):
                print(error)
            }
        })
    }

    func savePrice(price: CategoryPrice) {
        try! realm.write {
            realm.add(price, update: true)
        }
    }

}
