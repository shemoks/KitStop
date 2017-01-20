//
//  CategoryCell.swift
//  KitStop
//
//  Created by Mac on 12/22/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
        func configure(with category: Category) {
            textLabel?.text = category.title
        }

}
