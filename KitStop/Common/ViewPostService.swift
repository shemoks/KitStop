//
//  ViewPostService.swift
//  KitStop
//
//  Created by Mac on 1/17/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import RealmSwift
import SwiftyJSON

class ViewPostService: NSObject, ViewPostServiceProtocol {

    fileprivate let manager: ApiManagerProtocol

    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }
        func getAllKits(idKit: String, forSale: Bool, postValue: @escaping ((Post, _ errorCode: Int?) -> ())) {
                let _ = manager.apiRequest(.viewKitByOwner(idKit: idKit), parameters:[:], headers: nil).apiResponse(completionHandler: {
                    response in
                    switch response.result{
                    case .success(let json):
                        print(json)
                        if json["success"] == true {
                            let arrProducts = Post()
                            var generalProperty = [Property]()
                            var additionalProperty = [Property]()
                            var otherProperty = [Property]()
                            arrProducts.categoryId = json["data"]["category"]["_id"].stringValue
                            arrProducts.categoryTitle = json["data"]["category"]["title"].stringValue
                            arrProducts.createAt = json["data"]["updatedAt"].stringValue
                            let owner = User()
                            owner.avatar = json["data"]["owner"]["photoUrl"].stringValue
                            owner.country = json["data"]["owner"]["country"].stringValue
                            owner.name = json["data"]["owner"]["name"].stringValue
                            owner.surname = json["data"]["owner"]["surname"].stringValue
                            owner.id = json["data"]["owner"]["_id"].stringValue
                            arrProducts.owner = owner
                            let images = json["data"]["images"]
                            arrProducts.isPrivate = json["data"]["isPrivate"].boolValue
                            arrProducts.id = json["data"]["_id"].stringValue
                            var postImages = [String]()
                            for value in images {
                                postImages.append(value.1.stringValue)
                            }
                            arrProducts.imagesString = postImages
                            arrProducts.mainImage = json["data"]["mainImage"].stringValue
                            let products = json["data"]["structure"]
                            for product in products {
                                if product.1["onlyForKits"].boolValue || product.1["onlyForSales"].bool == nil {
                                    let resultValue = self.createObject(product: product.1)
                                    switch resultValue.section {
                                    case 1:
                                        generalProperty.append(resultValue.property)
                                    case 2:
                                        additionalProperty.append(resultValue.property)
                                    case 3:
                                        arrProducts.description = resultValue.property
                                    case 0:
                                        otherProperty.append(resultValue.property)
                                    default:
                                        arrProducts.notes = resultValue.property
                                    }
                                }
                            }
                            let metaData = json["data"]["structure"]["metaData"]
                            for product in metaData {
                                if product.1["onlyForKits"].boolValue || product.1["onlyForSales"].bool == nil {
                                    let resultValue = self.createObject(product: product.1)
                                    switch resultValue.section {
                                    case 1:
                                        resultValue.property.metadata = true
                                        arrProducts.metadata.append(resultValue.property)
                                        generalProperty.append(resultValue.property)
                                    case 2:
                                        resultValue.property.metadata = true
                                        arrProducts.metadata.append(resultValue.property)
                                        additionalProperty.append(resultValue.property)
                                    case 3:
                                        arrProducts.description = resultValue.property
                                    default:
                                        arrProducts.notes = resultValue.property
                                    }
                                }
                            }
                            let salesDetails = json["data"]["structure"]["salesDetails"]
                            for product in salesDetails {
                                let resultValue = self.createObject(product: product.1)
                                resultValue.property.salesDetails = true
                                arrProducts.salesDetails.append(resultValue.property)
                            }
                            arrProducts.salesDetails = self.sortedProperty(customArray: arrProducts.salesDetails)
                            arrProducts.generalProperty = self.sortedProperty(customArray: generalProperty)
                            arrProducts.title = arrProducts.generalProperty.first!
                            arrProducts.generalForViewProperty = self.propertyWithoutEmptyValue(property: arrProducts.generalProperty)
                            arrProducts.generalForViewProperty.remove(at: 0)
                            arrProducts.additionalProperty = self.sortedProperty(customArray: additionalProperty)
                            arrProducts.additionalForViewProperty = self.propertyWithoutEmptyValue(property: arrProducts.additionalProperty)
                            arrProducts.otherProperty = self.sortedProperty(customArray:otherProperty)
                            arrProducts.otherForViewProperty = self.propertyWithoutEmptyValue(property: arrProducts.otherProperty)
                            postValue(arrProducts, nil)
                        } else {
                            postValue(Post(), response.response?.statusCode)
                        }

                    case .failure(let error):
                        postValue(Post(), (error as NSError).code)
                    }
                })
            }

    func propertyWithoutEmptyValue(property: [Property]) -> [Property] {
        var data = [Property]()
        for propertyItem in property {
            if propertyItem.textValue != "" {
                data.append(propertyItem)
            }
        }
        return data
    }

    func getAllKitsForSale(idKit: String, forSale: Bool, postValue: @escaping ((Post, _ errorCode: Int?) -> ())) {
            let _ = manager.apiRequest(.viewKitForSale(idKit: idKit), parameters:[:], headers: nil).apiResponse(completionHandler: {
                response in
                switch response.result{
                case .success(let json):
                    print(json)
                    if json["success"] == true {
                        let arrProducts = Post()
                        var generalProperty = [Property]()
                        var additionalProperty = [Property]()
                        var otherProperty = [Property]()
                        arrProducts.categoryId = json["data"]["category"]["_id"].stringValue
                        arrProducts.categoryTitle = json["data"]["category"]["title"].stringValue
                        arrProducts.createAt = json["data"]["updatedAt"].stringValue
                        let owner = User()
                        owner.avatar = json["data"]["owner"]["photoUrl"].stringValue
                        owner.country = json["data"]["owner"]["country"].stringValue
                        owner.name = json["data"]["owner"]["name"].stringValue
                        owner.surname = json["data"]["owner"]["surname"].stringValue
                        owner.id = json["data"]["owner"]["_id"].stringValue
                        arrProducts.owner = owner
                        let images = json["data"]["images"]
                        arrProducts.isPrivate = json["data"]["isPrivate"].boolValue
                        arrProducts.id = json["data"]["_id"].stringValue
                        var postImages = [String]()
                        for value in images {
                            postImages.append(value.1.stringValue)
                        }
                        arrProducts.imagesString = postImages
                        arrProducts.mainImage = json["data"]["mainImage"].stringValue
                        let products = json["data"]["structure"]
                        for product in products {
                            if product.1["onlyForSale"].boolValue || product.1["onlyForKits"].bool == nil {
                                let resultValue = self.createObject(product: product.1)
                                switch resultValue.section {
                                case 1:
                                    generalProperty.append(resultValue.property)
                                case 2:
                                    additionalProperty.append(resultValue.property)
                                case 3:
                                    arrProducts.description = resultValue.property
                                case 0:
                                    otherProperty.append(resultValue.property)
                                default:
                                    arrProducts.notes = resultValue.property
                                }
                            }
                        }
                        let metaData = json["data"]["structure"]["metaData"]
                        for product in metaData {
                            if product.1["onlyForSale"].boolValue || product.1["onlyForKits"].bool == nil {
                                let resultValue = self.createObject(product: product.1)
                                switch resultValue.section {
                                case 1:
                                    generalProperty.append(resultValue.property)
                                    resultValue.property.metadata = true
                                    arrProducts.metadata.append(resultValue.property)
                                case 2:
                                    resultValue.property.metadata = true
                                    additionalProperty.append(resultValue.property)
                                    arrProducts.metadata.append(resultValue.property)
                                case 3:
                                    arrProducts.description = resultValue.property
                                default:
                                    arrProducts.notes = resultValue.property
                                }

                            }
                        }
                        let salesDetails = json["data"]["structure"]["salesDetails"]
                        for product in salesDetails {
                            let resultValue = self.createObject(product: product.1)
                            resultValue.property.salesDetails = true
                            arrProducts.salesDetails.append(resultValue.property)
                        }
                        arrProducts.salesDetails = self.sortedProperty(customArray: arrProducts.salesDetails)
                        arrProducts.generalProperty = self.sortedProperty(customArray: generalProperty)
                        arrProducts.title = arrProducts.generalProperty.first!
                        arrProducts.generalForViewProperty = self.propertyWithoutEmptyValue(property: arrProducts.generalProperty)
                        arrProducts.generalForViewProperty.remove(at: 0)
                        arrProducts.additionalProperty = self.sortedProperty(customArray: additionalProperty)
                        arrProducts.additionalForViewProperty = self.propertyWithoutEmptyValue(property: arrProducts.additionalProperty)
                        arrProducts.otherProperty = self.sortedProperty(customArray:otherProperty)
                        arrProducts.otherForViewProperty = self.propertyWithoutEmptyValue(property: arrProducts.otherProperty)
                        postValue(arrProducts, nil)
                    } else {

                        postValue(Post(), response.response?.statusCode)
                    }

                case .failure(let error):
                    postValue(Post(), (error as NSError).code)
                }
            })
        }


    func createObject(product: JSON) -> ResultJson {
        var newElement: Property
        let section = product["group"].intValue
        switch section {
        case 1:
            newElement = element(product: product, section: 1)
            return ResultJson(property: newElement, section: 1)
        case 2:
            newElement = element(product: product, section: 2)
            return ResultJson(property: newElement, section: 2)
        case 3:
            newElement = element(product: product, section: 3)
            return ResultJson(property: newElement, section: 3)
        case 4:
            newElement = element(product: product, section: 4)
            return ResultJson(property: newElement, section: 4)
        default:
            newElement = element(product: product, section: 0)
            return ResultJson(property: newElement, section: 0)
        }
    }

    func element(product: JSON, section: Int) -> Property {
        let newElement = Property()
        newElement.group = section
        newElement.isOptional = product["mandatory"].boolValue
        newElement.title = product["name"].stringValue
        newElement.textValue = product["currentData"].stringValue
        var arrDate = [Other]()
        let data = product["data"]
        if let array = data.arrayObject {
            newElement.isSelect = true
            newElement.typeOfData = .array
            for value in array {
                if let element = value as? String {
                    let newData = Other()
                    newData.name = element
                    newData.limit = 0
                    newData.placeholder = ""
                    newData.title = ""
                    arrDate.append(newData)
                }
                if let element = value as? NSDictionary {
                    let newData = Other()
                    if element.value(forKey: "data") != nil {
                        if let value = element.value(forKey: "data") as? String {
                            newData.data = value
                            newData.type = .string
                            if (element.value(forKey: "data") as? Double) != nil {
                                newData.data = String(value)
                                newData.type = .double
                            }
                            if let dictionaryValue = element.value(forKey: "data") as? NSDictionary {
                                newData.data   = ""
                            }
                        }
                    }
                    if  element.value(forKey: "limit") != nil {
                        newData.limit = element.value(forKey: "limit") as? Int
                    }
                    if element.value(forKey: "name") != nil {
                        newData.name = element.value(forKey: "name") as! String
                    }
                    if element.value(forKey: "placeholder") != nil {
                        newData.placeholder = element.value(forKey: "placeholder") as? String
                    }
                    if element.value(forKey: "title") != nil {
                        newData.title = (element.value(forKey: "title") as? String)!
                    }
                    arrDate.append(newData)
                }
            }
            newElement.list = arrDate
            newElement.placeholder = product["placeholder"].stringValue
        }
        //            let textValue = product["data"].intValue
        //            newElement.textValue = textValue
        if data.string != nil {
            newElement.typeOfData = .string
            newElement.placeholder = product["placeholder"].stringValue
        }

        if data.int != nil {
            newElement.typeOfData = .int
            newElement.numberValue = data.intValue
            newElement.placeholder = product["placeholder"].stringValue
        }
        newElement.limit = product["limit"].intValue
        newElement.units = product["units"].stringValue
        newElement.order = product["order"].intValue
        return newElement
    }

    func sortedProperty(customArray: [Property]) -> [Property] {
        let sortedArray = customArray.sorted {
            $0.order < $1.order
        }
        return sortedArray
    }

    func removeKit(idKit: String, completitionBlock: @escaping (Int?) -> ()) {
        let _ = manager.apiRequest(.removeKit(idKit: idKit), parameters: [:], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                print(json["success"])
                if json["success"].boolValue {
                    completitionBlock(nil)
                } else {
                    print("error \(json)")
                    completitionBlock(response.response?.statusCode)
                }
            case .failure(let error):
                print(error)
                completitionBlock((error as NSError).code)
            }
        })
    }

    func removeKitForSale(idKit: String, completitionBlock: @escaping (Int?) -> ()) {
        let _ = manager.apiRequest(.removeKitForSale(idKit: idKit), parameters: [:], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result{
            case .success(let json):
                print(json["success"])
                if json["success"].boolValue {
                    completitionBlock(nil)
                } else {
                    print("error \(json)")
                    completitionBlock(response.response?.statusCode)
                }
            case .failure(let error):
                print(error)
                completitionBlock((error as NSError).code)
            }
        })
    }
    
}


