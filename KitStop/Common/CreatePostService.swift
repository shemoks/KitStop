//
//  CreatePostService.swift
//  KitStop
//
//  Created by Mac on 1/10/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct ResultJson {
    var property: Property
    var section: Int
}

class CreatePostService: NSObject, CreatePostServiceProtocol {
    fileprivate let manager: ApiManagerProtocol

    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }

    func getStructureOfCategory(onlyForSale: Bool, idCategory: String, categoryStructure: @escaping ((Post, _ errorCode: Int?) -> ())) {
        if onlyForSale {
            let _ = manager.apiRequest(.getStructureOfCategory(id: idCategory), parameters: [:], headers: nil).apiResponse(completionHandler: {
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
                        arrProducts.generalProperty = self.sortedProperty(customArray: generalProperty)
                        arrProducts.additionalProperty = self.sortedProperty(customArray: additionalProperty)
                        arrProducts.otherProperty = self.sortedProperty(customArray:otherProperty)
                        categoryStructure(arrProducts, nil)
                    } else {

                        categoryStructure(Post(), response.response?.statusCode)
                    }

                case .failure(let error):
                    categoryStructure(Post(), (error as NSError).code)
                }
            })
        } else {
            let _ = manager.apiRequest(.getStructureOfCategory(id: idCategory), parameters: [:], headers: nil).apiResponse(completionHandler: {
                response in
                switch response.result {
                case .success(let json):
                    print(json)
                    if json["success"] == true {
                        let arrProducts = Post()
                        var generalProperty = [Property]()
                        var additionalProperty = [Property]()
                        var otherProperty = [Property]()
                        arrProducts.categoryId = json["data"]["category"]["_id"].stringValue
                        arrProducts.categoryTitle = json["data"]["category"]["title"].stringValue
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
                        arrProducts.generalProperty = self.sortedProperty(customArray: generalProperty)
                        arrProducts.additionalProperty = self.sortedProperty(customArray: additionalProperty)
                        arrProducts.otherProperty = self.sortedProperty(customArray:otherProperty)
                        categoryStructure(arrProducts, nil)
                    } else {

                        categoryStructure(Post(), response.response?.statusCode)
                    }

                case .failure(let error):
                    categoryStructure(Post(), (error as NSError).code)
                }
            })
        }

    }

    func savePost() {

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

}
