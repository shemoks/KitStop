//
//  FilterParametersService.swift
//  KitStop
//
//  Created by Mac on 12/19/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation

struct FilterObject {
    var filter: Filter
    var error: Error?
}

class FilterParametersService {

    var filterResult: ((FilterObject)->())?
    func getFilters() {
        var filterObject = FilterObject(filter: Filter(), error: nil)
        if Reachability.isConnectedToNetwork() == true {
            //request to server
            filterObject = FilterObject(filter: Filter(), error: nil)
            filterResult?(filterObject)
        } else {
            filterObject = FilterObject(filter: Filter(), error: NSError())
            filterResult?(filterObject)
        }
    }

    func getFilterObject (obj: AnyObject) -> FilterObject {
        let filter = Filter()
        var result = FilterObject(filter: Filter(), error: nil)
        return result
    }
}
