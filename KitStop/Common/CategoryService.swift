//
//  CategoryService.swift
//  KitStop
//
//  Created by sasha ataman on 03.01.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit
import Alamofire

class CategoryService: NSObject, CategoryServiceProtocol {
    fileprivate let manager: ApiManagerProtocol
    
    init(manager: ApiManagerProtocol = SessionManager.default) {
        self.manager = manager
    }
    
    func fetchCategory(result: @escaping ([CategoryList]) -> ()) {
        let _ = manager.apiRequest(.getCategory()).apiResponse(completionHandler: {
            response in
            switch response.result {
            case .success(let json):
                var categoryList = [CategoryList]()
                for object in json["data"] {
                    var category = CategoryList()
                    category.id = object.1["_id"].intValue
                    category.title = object.1["title"].stringValue
                    categoryList.append(category)
                }
                print(json)
            case .failure(let error):
                print(error)
            }

            
        })
    }

}
