//
//  KitDetailsModel.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 1/16/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation

class KitDetailsModel {
    
    var header:String?
    var contents:String?
    var placeholder: String?
    
    init(header: String?, contents: String?, placeholder: String?) {
        self.header = header
        self.contents = contents
        self.placeholder = placeholder
    }
    
    
}
