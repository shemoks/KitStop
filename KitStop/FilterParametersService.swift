//
//  FilterParametersService.swift
//  KitStop
//
//  Created by Mac on 12/19/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation

struct FilterObject {
    var categories: Filter
    var error: Error?
}

struct Categories {
    var categories: [Category]
    var error: NSError?
}

class FilterParametersService {

    var filterResult: ((Categories)->())?
    func getCategories() {
        var resultRequest = Categories(categories: [Category](), error: nil)
        if Reachability.isConnectedToNetwork() == true {
            //request to server
            resultRequest = Categories(categories: [Category](), error: nil)
            filterResult?(resultRequest)
        } else {
            resultRequest = Categories(categories: [Category](), error: NSError())
            filterResult?(resultRequest)
        }
    }


}
