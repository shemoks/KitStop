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
            let general = ["brand", "model", "serial #"]
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
                                let newItem = ViewProperty()
                                newItem.title = value.0
                                newItem.text = String(describing: value.1)
                                generalProperty.append(newItem)
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
                            description.text = json["data"]["description"].stringValue
                            post.description = description
                        } else {
                            let description = ViewProperty()
                            description.title = "Description"
                            description.text = "No Description is entered"
                            post.description = description
                        }
                        if json["data"]["notes"] != JSON.null {
                            let notes = ViewProperty()
                            notes.title = "Owner notes"
                            notes.text = json["data"]["description"].stringValue
                            post.notes = notes
                        } else {
                            let notes = ViewProperty()
                            notes.title = "Owner notes"
                            notes.text = "No Owner Notes is entered"
                            post.notes = notes
                        }
                        let metaDataArray = json["data"]["metaData"]
                        for product in metaDataArray {
                            let newItem = ViewProperty()
                            newItem.title = product.0
                            newItem.text = String(describing: product.1)
                            metaData.append(newItem)
                        }
                        if json["data"]["forSale"] != JSON.null {
                            let forSale = json["data"]["forSale"]
                            for product in forSale {
                                let newItem = ViewProperty()
                                newItem.title = product.0
                                newItem.text = String(describing: product.1)
                                saleData.append(newItem)
                            }
                        }
                        var saleDateItems = [ViewProperty]()
                        let newItemPurchaseDate = ViewProperty()
                        let purch = json["data"]["purchaseDate"].doubleValue
                        newItemPurchaseDate.text = Date(timeIntervalSince1970: TimeInterval(purch)).description
                        newItemPurchaseDate.title =  "Purchase Date"
                        saleDateItems.append(newItemPurchaseDate)
                        let newItemPurchaseDateNext = ViewProperty()
                        newItemPurchaseDateNext.text = json["data"]["purchasePrice"].stringValue
                        newItemPurchaseDateNext.title =  "Purchase Price"
                        saleDateItems.append(newItemPurchaseDateNext)
                        post.createAt = json["data"]["updatedAt"].stringValue
                        let owner = User()
                        owner.avatar = json["data"]["owner"]["photo_url"].stringValue
                        if json["data"]["owner"]["country"] != JSON.null {
                            owner.country = json["data"]["owner"]["country"].stringValue
                        } else {
                            owner.country = "USA"
                        }
                        owner.name = json["data"]["owner"]["name"].stringValue
                        owner.surname = json["data"]["owner"]["surname"].stringValue
                        owner.id = json["data"]["owner"]["_id"].stringValue
                        post.owner = owner
                        post.metaData = metaData
                        post.saleData = saleDateItems
                        post.generalProperty = generalProperty
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
}


