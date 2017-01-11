//
//  ValidationPost.swift
//  KitStop
//
//  Created by Mac on 1/11/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import UIKit

class ValidationPost {
    func validationBeforeNext(post: Post) -> Bool {
        var result: Bool = true

        for property in post.additionalProperty {

            if (property.isOptional == true && (property.textValue.characters.count == 0 || property.textValue.trimmingCharacters(in: .whitespaces).characters.count == 0))  {
                property.isValidate = false
                result = false
            } else {
                property.isValidate = true
            }
        }
        for property in post.generalProperty {

            if (property.isOptional == true && (property.textValue.characters.count == 0 || property.textValue.trimmingCharacters(in: .whitespaces).characters.count == 0))  {
                property.isValidate = false
                result = false
            } else {
                property.isValidate = true
            }
        }
        if post.images.contains(UIImage.init(named: "required")!) {
            result = false
        }
        return result
    }
}
