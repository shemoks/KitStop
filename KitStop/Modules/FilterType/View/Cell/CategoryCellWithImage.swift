//
//  CategoryCellWithImage.swift
//  KitStop
//
//  Created by Mac on 1/19/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

class CategoryCellWithImage: UITableViewCell {

   @IBOutlet weak var categoryIcon: UIImageView!

    @IBOutlet weak var title: UILabel!

    func configureCell(category: Category) {
        title.text = category.title
        categoryIcon.image = UIImage.init(named: category.title)
    }

}
