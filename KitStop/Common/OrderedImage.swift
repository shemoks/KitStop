//
//  OrderedImage.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 2/10/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation

class OrderedImage {
    let key: Int
    let url: String
    
    init(key: Int, url: String) {
        self.key = key
        self.url = url
    }
    
    func getDictFormat() -> [String: AnyObject] {
        return ["key":key as AnyObject, "url": url as AnyObject]
    }
}
