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
                        arrProducts.generalProperty = generalProperty
                        arrProducts.additionalProperty = additionalProperty
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
                        arrProducts.generalProperty = generalProperty
                        arrProducts.additionalProperty = additionalProperty
                        categoryStructure(arrProducts, nil)
                    } else {

                        categoryStructure(Post(), response.response?.statusCode)
                    }

                case .failure(let error):
                    categoryStructure(Post(), (error as NSError).code)
                }
            })        }

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
        let data = product["data"].arrayValue
        if data != [] {
        for value in data {
            let newData = Other(name: value["name"].stringValue, data: value["data"].stringValue, limit: value["limit"].intValue)
            arrDate.append(newData)
        }
        newElement.data = arrDate
        if arrDate.count > 1 {
            newElement.isSelect = true
        }
        } else {
            let textValue = product["data"].stringValue
            newElement.textValue = textValue
            newElement.placeholder = product["placeholder"].stringValue
        }
        newElement.limit = product["limit"].intValue
        newElement.units = product["units"].stringValue
        return newElement
    }

}
