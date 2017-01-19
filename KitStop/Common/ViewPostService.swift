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
            let _ = manager.apiRequest(.viewKitByOwner(idKit: idKit), parameters: [:], headers: nil).apiResponse(completionHandler: {
                response in
                switch response.result{
                case .success(let json):
                    if json["success"] == true {
                        let post = ViewPost()
                        var generalProperty = [ViewProperty]()
                        var metaData = [ViewProperty]()
                        var saleData = [ViewProperty]()
                        var postImages = [String]()
                        let images = json["data"]["images"]
                        post.title = json["data"]["title"].stringValue
                        post.isPrivate = json["data"]["isPrivate"].boolValue
                        post.id = json["data"]["_id"].stringValue
                        for value in images {
                            postImages.append(value.1.stringValue)
                        }
                        post.images = postImages
                        post.mainImage = postImages.first!
                        post.description = json["data"]["description"].stringValue
                        post.notes = json["data"]["notes"].stringValue
                        let metaDataArray = json["data"]["metaData"].arrayObject
                        for product in metaDataArray! {
                            let newItem = ViewProperty()
                            if let item = product as? NSDictionary {
                                newItem.title = (item.allKeys.first as? String)!
                                newItem.text = item.value(forKey: newItem.title) as! String
                                metaData.append(newItem)
                            }
                        }
                        if let forSale = json["data"]["forSale"].arrayObject {
                            for product in forSale {
                                let newItem = ViewProperty()
                                if let item = product as? NSDictionary {
                                    newItem.title = (item.allKeys.first as? String)!
                                    newItem.text = item.value(forKey: newItem.title) as! String
                                    saleData.append(newItem)
                                }

                            }
                        }
                        post.metaData = metaData
                        post.saleData = saleData
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

