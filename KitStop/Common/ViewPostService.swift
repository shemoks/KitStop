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

    func getKit(idKit: String, forSale: Bool, postValue: @escaping ((ViewPost, _ errorCode: Int?) -> ())) {
        if !forSale {
            let general = ["brand", "model", "serialNumber"]
            let _ = manager.apiRequest(.viewKitByOwner(idKit: idKit), parameters: [:], headers: nil).apiResponse(completionHandler: {
                response in
                switch response.result{
                case .success(let json):
                    print(json)
                    if json["success"] == true {
                        let post = ViewPost()
                        var generalProperty = [ViewProperty]()
                        var metaData = [ViewProperty]()
                        var saleData = [ViewProperty]()
                        var postImages = [String]()
                        let generalValues = json["data"]
                        for value in generalValues {
                            if general.contains(value.0) {
                                if value.1.stringValue != "" {
                                    let newItem = ViewProperty()
                                    let valueTitle = String(describing: value.0).capitalizingFirstLetter().dividedByUppercaseLetter()
                                    newItem.title = valueTitle
                                    newItem.text = value.1.stringValue
                                    newItem.order = value.1.intValue
                                    generalProperty.append(newItem)
                                }
                            }
                        }
                        let images = json["data"]["images"]
                        post.title = json["data"]["title"].stringValue
                        post.isPrivate = json["data"]["isPrivate"].boolValue
                        post.id = json["data"]["_id"].stringValue
                        for value in images {
                            postImages.append(value.1.stringValue)
                        }
                        post.images = postImages
                        post.mainImage = json["data"]["mainImage"].stringValue
                        if json["data"]["description"] != JSON.null {
                            let description = ViewProperty()
                            description.title = "Description"
                            if json["data"]["description"].stringValue != "" {
                                description.text = json["data"]["description"].stringValue
                            } else {
                                description.text = "No Description"
                            }

                            post.description = description
                        } else {
                            let description = ViewProperty()
                            description.title = "Description"
                            description.text = "No Description"
                            post.description = description
                        }
                        if json["data"]["notes"] != JSON.null {
                            let notes = ViewProperty()
                            notes.title = "Owner notes"
                            if json["data"]["notes"].stringValue != "" {
                                notes.text = json["data"]["notes"].stringValue
                            } else {
                                notes.text = "No Owner Notes"
                            }
                            post.notes = notes
                        } else {
                            let notes = ViewProperty()
                            notes.title = "Owner notes"
                            notes.text = "No Owner Notes"
                            post.notes = notes
                        }
                        let metaDataArray = json["data"]["metaData"]
                        for product in metaDataArray {
                            let newItem = ViewProperty()
                            newItem.title = product.0.capitalizingFirstLetter().dividedByUppercaseLetter()
                            newItem.text = String(describing: product.1)
                            newItem.order = product.1.intValue
                            if newItem.text != "" {
                            metaData.append(newItem)
                            }
                        }
                        let category = json["data"]["category"]["title"].stringValue
                        post.category = category
                        if json["data"]["forSale"] != JSON.null {
                            let forSale = json["data"]["forSale"]
                            for product in forSale {
                                let newItem = ViewProperty()
                                newItem.title = product.0.capitalizingFirstLetter().dividedByUppercaseLetter()
                                newItem.text = String(describing: product.1)
                                newItem.order = product.1.intValue
                                if newItem.text != "" {
                                saleData.append(newItem)
                                }
                            }
                        }
                        var saleDateItems = [ViewProperty]()
                        let newItemPurchaseDate = ViewProperty()
                        if json["data"]["purchaseDate"].stringValue != "" {
                            let purch = json["data"]["purchaseDate"].doubleValue
                            let dateFormatter = DateFormatter()
                            let dateValue = Date(timeIntervalSince1970: TimeInterval(purch))
                            dateFormatter.dateFormat = "dd MMM yyyy"
                            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                            let timeStamp = dateFormatter.string(from: dateValue)
                            newItemPurchaseDate.text = timeStamp
                            newItemPurchaseDate.title =  "Purchase Date"
                            saleDateItems.append(newItemPurchaseDate)
                        }
                        if json["data"]["purchasePrice"].stringValue != "" {
                            let newItemPurchaseDateNext = ViewProperty()
                            newItemPurchaseDateNext.text = "$" + json["data"]["purchasePrice"].stringValue
                            newItemPurchaseDateNext.title =  "Purchase Price"
                            saleDateItems.append(newItemPurchaseDateNext)
                        }
                        post.createAt = json["data"]["updatedAt"].stringValue
                        let owner = User()
                        owner.avatar = json["data"]["owner"]["photoUrl"].stringValue
                        if json["data"]["owner"]["country"] != JSON.null {
                            owner.country = json["data"]["owner"]["country"].stringValue
                        } else {
                            owner.country = "USA"
                        }
                        owner.name = json["data"]["owner"]["name"].stringValue
                        owner.surname = json["data"]["owner"]["surname"].stringValue
                        owner.id = json["data"]["owner"]["_id"].stringValue
                        post.owner = owner
                        post.metaData = self.sortedProperty(customArray: metaData)
                        post.saleData = self.sortedProperty(customArray: saleDateItems)
                        post.generalProperty = self.sortedProperty(customArray: generalProperty)
                        postValue(post, nil)
                    } else {
                        postValue (ViewPost(), response.response?.statusCode)
                    }
                case .failure(let error):
                    postValue(ViewPost(), (error as NSError).code)
                }
            })
        }
    }


    func getKitForSale(idKit: String, forSale: Bool, postValue: @escaping ((ViewPost, _ errorCode: Int?) -> ())) {
        if forSale {
            let general = ["brand", "model", "serialNumber"]
            let _ = manager.apiRequest(.viewKitForSale(idKit: idKit), parameters: [:], headers: nil).apiResponse(completionHandler: {
                response in
                switch response.result{
                case .success(let json):
                    print(json)
                    if json["success"] == true {
                        let post = ViewPost()
                        var generalProperty = [ViewProperty]()
                        var metaData = [ViewProperty]()
                        var saleData = [ViewProperty]()
                        var postImages = [String]()
                        let conditon = ViewProperty()
                        conditon.text = json["data"]["salesDetails"]["condition"].stringValue
                        conditon.title = "Condition"
                        generalProperty.append(conditon)
                        let price = ViewProperty()
                        //           let currency = json["data"]["salesDetails"]["currency"].stringValue
                        price.text = "$" + String(describing: json["data"]["salesDetails"]["price"].intValue)
                        price.title = "Price"
                        saleData.append(price)
                        let generalValues = json["data"]
                        for value in generalValues {
                            if general.contains(value.0) {
                                if value.1.stringValue != "" {
                                    let newItem = ViewProperty()
                                    let valueTitle = String(describing: value.0).capitalizingFirstLetter().dividedByUppercaseLetter()
                                    newItem.title = valueTitle
                                    newItem.text = value.1.stringValue
                                    newItem.order = value.1.intValue
                                    generalProperty.append(newItem)
                                }
                            }
                        }
                        let images = json["data"]["images"]
                        post.title = json["data"]["title"].stringValue
                        post.isPrivate = json["data"]["isPrivate"].boolValue
                        post.id = json["data"]["_id"].stringValue
                        let category = json["data"]["category"]["title"].stringValue
                        post.category = category
                        for value in images {
                            postImages.append(value.1.stringValue)
                        }
                        post.images = postImages
                        post.mainImage = json["data"]["mainImage"].stringValue
                        if json["data"]["description"] != JSON.null {
                            let description = ViewProperty()
                            description.title = "Description"
                            if json["data"]["description"].bool != nil {
                                description.text = json["data"]["description"].stringValue
                            } else {
                                description.text = "No Description"
                            }

                            post.description = description
                        } else {
                            let description = ViewProperty()
                            description.title = "Description"
                            description.text = "No Description"
                            post.description = description
                        }
                        if json["data"]["notes"] != JSON.null {
                            let notes = ViewProperty()
                            notes.title = "Owner notes"
                            if json["data"]["notes"].bool != nil {
                                notes.text = json["data"]["notes"].stringValue
                            } else {
                                notes.text = "No Owner Notes"
                            }
                            post.notes = notes
                        } else {
                            let notes = ViewProperty()
                            notes.title = "Owner notes"
                            notes.text = "No Owner Notes"
                            post.notes = notes
                        }
                        let metaDataArray = json["data"]["metaData"]
                        for product in metaDataArray {
                            let newItem = ViewProperty()
                            newItem.title = product.0.capitalizingFirstLetter().dividedByUppercaseLetter()
                            newItem.text = String(describing: product.1)
                            newItem.order = product.1.intValue
                            metaData.append(newItem)
                        }
                        if json["data"]["forSale"] != JSON.null {
                            let forSale = json["data"]["forSale"]
                            for product in forSale {
                                let newItem = ViewProperty()
                                newItem.title = product.0.capitalizingFirstLetter().dividedByUppercaseLetter()
                                newItem.text = String(describing: product.1)
                                saleData.append(newItem)
                            }
                        }
                        post.createAt = json["data"]["updatedAt"].stringValue
                        let owner = User()
                        owner.avatar = json["data"]["owner"]["photoUrl"].stringValue
                        if json["data"]["owner"]["country"] != JSON.null {
                            owner.country = json["data"]["owner"]["country"].stringValue
                        } else {
                            owner.country = "USA"
                        }
                        owner.name = json["data"]["owner"]["name"].stringValue
                        owner.surname = json["data"]["owner"]["surname"].stringValue
                        owner.id = json["data"]["owner"]["_id"].stringValue
                        post.owner = owner
                        post.metaData = self.sortedProperty(customArray: metaData)
                        post.saleData = self.sortedProperty(customArray: saleData)
                        post.generalProperty = self.sortedProperty(customArray: generalProperty)
                        postValue(post, nil)
                    } else {
                        postValue (ViewPost(), response.response?.statusCode)
                    }
                case .failure(let error):
                    postValue(ViewPost(), (error as NSError).code)
                }
            })
        }
    }

    func sortedProperty(customArray: [ViewProperty]) -> [ViewProperty] {
        let sortedArray = customArray.sorted {
            $0.order > $1.order
        }
        return sortedArray
    }

}


