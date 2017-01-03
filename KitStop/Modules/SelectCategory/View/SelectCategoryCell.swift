//
//  SelectCategoryCell.swift
//  KitStop
//
//  Created by sasha ataman on 03.01.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

class SelectCategoryCell: UITableViewCell {

    
    @IBOutlet weak var category: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func setupCell(category: CategoryList) {
        title.text = category.title
        self.category.image = UIImage.init(named: category.title)
    }

}
