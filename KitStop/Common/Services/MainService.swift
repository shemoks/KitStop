//
//  MainService.swift
//  KitStop
//
//  Created by sasha ataman on 27.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit
import Alamofire

class MainService: NSObject, MainServiceProtocol {
    
    fileprivate let manager: ApiManagerProtocol
    let filterManager: FilterManager?
    
    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
        filterManager = FilterManager()
    }
    
    func fetchAllKits(page: Int, filterButton: UIButton?, completionBlock: @escaping (_ error: Int?) -> ()) {
        var params = [String : AnyObject]()
        filterManager?.getCurrentFilter(section: true, result: {
            filter in
            if let filter = filter.first {
                if let filterButton = filterButton {
                    filterButton.setImage(UIImage.init(named: "filter_active_icon"), for: .normal)
                }
                params = ["page" : page as AnyObject,
                          "perPage" : 5 as AnyObject,
                          "category" : filter.number as AnyObject]
            } else {
                filterButton?.setImage(UIImage.init(named: "filter_icon"), for: .normal)
                params = ["page" : page as AnyObject,
                          "perPage" : 5 as AnyObject]
            }
        })
        let _ = manager.apiRequest(.getKits(), parameters: params, headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result {
            case .success(let json):
                if json["success"].boolValue {
                    for kit in json["data"]["docs"] {
                        let kits = KitModel()
                        kits.id = kit.1["_id"].stringValue
                        kits.mainImage = kit.1["mainImage"].stringValue
                        kits.title = kit.1["title"].stringValue
                        kits.owner = kit.1["owner"].stringValue
                        kits.isPrivate = kit.1["isPrivate"].boolValue
                        kits.type = "Kits"
                        do {
                            try KitRealmManager.sharedManager.insertItem(item: kits)
                        } catch (let error){
                            print("\(error)")
                        }

                    }
                    KitRealmManager.sharedManager.showCollectionView = true
                    LoadingIndicatorView.hide()
                    completionBlock(nil)
                } else {
                    LoadingIndicatorView.hide()
                    completionBlock(response.response?.statusCode)
                }
                print(json)
            case .failure(let error):
                print(error)
                completionBlock((error as NSError).code)
            }
        })
        
    }
    
    func fetchAllKitFolio(page: Int, completionBlock: @escaping (_ error: Int?) -> ()) {
        let _ = manager.apiRequest(.getKitFolio(), parameters: ["page" : page as AnyObject, "perPage" : 5 as AnyObject], headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result {
            case .success(let json):
                if json["success"].boolValue {
                    for kit in json["data"]["docs"] {
                        let kitFolio = KitModel()
                        kitFolio.id = kit.1["_id"].stringValue
                        kitFolio.mainImage = kit.1["mainImage"].stringValue
                        kitFolio.title = kit.1["title"].stringValue
                        kitFolio.owner = kit.1["owner"].stringValue
                        kitFolio.type = "KitFolio"
                        do {
                            try KitRealmManager.sharedManager.insertItem(item: kitFolio)
                        } catch (let error){
                            print("\(error)")
                        }
                    }
                    KitRealmManager.sharedManager.showCollectionView = true
                    LoadingIndicatorView.hide()
                    completionBlock(nil)
                } else {
                    LoadingIndicatorView.hide()
                    completionBlock(response.response?.statusCode)
                }
                print(json)
            case .failure(let error):
                print(error)
                completionBlock((error as NSError).code)
            }
        })
    }
    
    func fetchAllKitsForSale(page: Int, filterButton: UIButton? ,completionBlock: @escaping (_ error: Int?) -> ()) {
        var params = [String : AnyObject]()
        filterManager?.getCurrentFilter(section: false, result: {
            filter in
            if let filter = filter.first {
                if let filterButton = filterButton {
                    filterButton.setImage(UIImage.init(named: "filter_active_icon"), for: .normal)
                }
                params = ["page" : page as AnyObject,
                              "perPage" : 5 as AnyObject,
                              "from" : filter.minValue as AnyObject,
                              "to" : filter.maxValue as AnyObject,
                              "category" : filter.number as AnyObject]
            } else {
                if let filterButton = filterButton {
                    filterButton.setImage(UIImage.init(named: "filter_icon"), for: .normal)
                }
                params = ["page" : page as AnyObject,
                          "perPage" : 5 as AnyObject]
            }
        })
        let _ = manager.apiRequest(.getKitsForSale(), parameters: params, headers: nil).apiResponse(completionHandler: {
            response in
            switch response.result {
            case .success(let json):
                if json["success"].boolValue {
                    for kit in json["data"]["docs"] {
                        let kitForSale = KitModel()
                        kitForSale.id = kit.1["_id"].stringValue
                        kitForSale.mainImage = kit.1["mainImage"].stringValue
                        kitForSale.title = kit.1["title"].stringValue
                        kitForSale.type = "KitForSale"
                        kitForSale.owner = kit.1["owner"].stringValue
                        if let price = kit.1["salesDetails"]["price"].double {
                            kitForSale.price.value = price
                        }
                        do {
                            try KitRealmManager.sharedManager.insertItem(item: kitForSale)
                        } catch (let error){
                            print("\(error)")
                        }
                    }
                    KitRealmManager.sharedManager.showCollectionView = true
                    LoadingIndicatorView.hide()
                    completionBlock(nil)
                } else {
                    LoadingIndicatorView.hide()
                    completionBlock(response.response?.statusCode)
                }
                print(json)
            case .failure(let error):
                print(error)
                let errorCode = (error as NSError).code
                if errorCode != -999 {
                    completionBlock(errorCode)
                }
            }
        })
    }
}
