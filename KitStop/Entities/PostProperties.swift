//
//  PostProperties.swift
//  KitStop
//
//  Created by Mac on 1/5/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

enum Type {
    case onlyForKits
    case onlyForSale
}

struct Description {
    var title: String = ""
    var text: String = ""
}

struct Other {
    var name: String = ""
    var data: String  = ""
    var limit: Int? = nil
}

class Property {
    dynamic  var title: String = ""
    var data = [Other]()
    dynamic var isSelect: Bool = false
    dynamic var currentData: String?
    dynamic var isOptional: Bool = false
    dynamic var placeholder: String? = nil
    dynamic var group: Int = 0
    var type: Type? = nil
    var units: String? = nil
    var limit: Int? = nil
    var textValue: String = ""
    var isValidate: Bool = true
}

class Post {

    var generalProperty = [Property]()
    var additionalProperty = [Property]()
    var description = Property()
    var notes = Property()
    var categoryTitle: String = ""
    var categoryId: String = ""
    var images = [UIImage]()
    
}

