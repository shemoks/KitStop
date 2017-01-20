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
enum dataType {
    case string
    case array
    case int
    case double
}

struct Description {
    var title: String = ""
    var text: String = ""
}

class Other {
    var data: String  = ""
    var title: String = ""
    var placeholder: String? = nil
    var name: String = ""
    var limit: Int? = nil
    var type: dataType = .string

}

class Property {

    dynamic  var title: String = ""
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
    var metadata: Bool = false
    var salesDetails: Bool = false
    var list: [Other]?
    var typeOfData: dataType = .string
    var numberValue: Int? = nil

}

class Post {

    var metadata = [Property]()
    var generalProperty = [Property]()
    var additionalProperty = [Property]()
    var description = Property()
    var notes = Property()
    var categoryTitle: String = ""
    var categoryId: String = ""
    var images = [UIImage]()
    var salesDetails = [Property]()
    var otherProperty = [Property]()

}

class ViewPost {

    var title: String = ""
    var mainImage: String = ""
    var metaData = [ViewProperty]()
    var generalProperty = [ViewProperty]()
    var images = [String]()
    var saleData = [ViewProperty]()
    var description = ViewProperty()
    var notes = ViewProperty()
    var isPrivate: Bool = false
    var tags = [String]()
    var owner = User()
    var id: String = ""
    var createAt: String = ""
    var category: String = ""
    
}

class ViewProperty {
    var title: String = ""
    var text: String = ""
}

