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
import SwiftyJSON

class FilterManager: NSObject, FilterManagerProtocol {

    fileprivate let manager: ApiManagerProtocol
    var notificationToken: NotificationToken!
    let realm = try! Realm()

    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }

    func categoryFromServer(arrayOfCategories: @escaping (([Category], _ errorCode: Int?) -> ())) {
        let _ = manager.apiRequest(.categories(), parameters: [:], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                if json["success"] == true {
                    let categories = json["data"]
                    for category in categories {
                        let newCategory = Category()
                        newCategory.number = category.1["_id"].stringValue
                        newCategory.isSelected = false
                        newCategory.title = category.1["title"].stringValue
                        self.saveInRealm(category: newCategory)
                        arrayOfCategories(self.getCategories(), nil)
                    }
                } else {
                    arrayOfCategories(self.getCategories(), response.response?.statusCode)
                }
            case .failure(let error):
                arrayOfCategories(self.getCategories(), (error as NSError).code)
            }
        })
    }

    func getProducts(filter: Filter, result: @escaping ((FilterResult, _ errorCode: Int?) -> ())) {
        if !filter.type {
            let _ = manager.apiRequest(.forSaleFilter(), parameters: ["from": filter.minPrice as AnyObject, "to": filter.maxPrice as AnyObject, "category": filter.idCategory as AnyObject], headers: nil).apiResponse(completionHandler: {
                response in
                switch response.result{
                case .success(let json):
                    print(json)
                    if json["success"] == true {
                        var arrProducts = [Product]()
                        let products = json["data"]["docs"]
                        for product in products {
                            let newProduct = Product(id: product.1["_id"].stringValue, title: product.1["title"].stringValue, salesDetails: SalesDetails(price: product.1["salesDetails"]["price"].doubleValue, id: product.1["salesDetails"]["_id"].stringValue
                            ), mainImage: product.1["mainImage"].stringValue, description: "", date: "", owner: "", imagesArray: [], isPrivate: false, total: 0)
                            arrProducts.append(newProduct)
                        }
                        let total = json["data"]["total"].intValue
                        let pages = json["data"]["pages"].intValue
                        let limit = json["data"]["limit"].intValue
                        let filterResult = FilterResult(products: arrProducts, total: total, pages: pages, limit: limit)
                        result(filterResult, nil)

                    } else {
                        result(FilterResult(products: [Product](), total: 0, pages: 0, limit: 0), response.response?.statusCode)
                    }

                case .failure(let error):
                    result(FilterResult(products: [Product](), total: 0, pages: 0, limit: 0), (error as NSError).code)
                }
            })
        } else {
            let _ = manager.apiRequest(.kitsFilter(), parameters: ["category": filter.idCategory as AnyObject], headers: nil).apiResponse(completionHandler: {
                response in
                switch response.result{
                case .success(let json):
                    print(json)
                    if json["success"] == true {
                        var arrProducts = [Product]()
                        let products = json["data"]["docs"]
                        for product in products {
                            let newProduct = Product(id: product.1["_id"].stringValue, title: product.1["title"].stringValue, salesDetails: nil, mainImage: product.1["mainImage"].stringValue, description: "", date: "", owner: "", imagesArray: [], isPrivate: product.1["isPrivate"].boolValue, total: 0)
                            arrProducts.append(newProduct)
                        }
                        let total = json["data"]["total"].intValue
                        let pages = json["data"]["pages"].intValue
                        let limit = json["data"]["limit"].intValue
                        let filterResult = FilterResult(products: arrProducts, total: total, pages: pages, limit: limit)
                        result(filterResult, nil)
                    } else {
                        result(FilterResult(products: [Product](), total: 0, pages: 0, limit: 0), response.response?.statusCode)
                    }
                case .failure(let error):
                    result(FilterResult(products: [Product](), total: 0, pages: 0, limit: 0), (error as NSError).code)
                }
            })
        }
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

    func getPrice(category: Category, result: @escaping ((CategoryPrice, _ errorCode: Int?) -> ())) {
        let _ = manager.apiRequest(.price(), parameters: ["category": category.number as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                print(json)
                if json["success"] == true {
                    let newPrice = CategoryPrice()
                    newPrice.number = category.number
                    let priceMaxValue = json["data"]["max"].intValue
                    let priceMinValue = json["data"]["min"].intValue
                    let price = Price(minValue: priceMinValue, maxValue: priceMaxValue)
                    newPrice.categoryPrice = price
                    self.savePrice(price: newPrice)
                    result(newPrice, nil)
                } else {
                     result(CategoryPrice(), response.response?.statusCode)
                }
            case .failure(let error):
                result(CategoryPrice(), (error as NSError).code)
            }
        })
    }

    func savePrice(price: CategoryPrice) {
        try! realm.write {
            realm.add(price, update: true)
        }
    }
    
}
