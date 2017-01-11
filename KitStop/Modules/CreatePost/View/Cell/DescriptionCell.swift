//
//  DescriptionCell.swift
//  KitStop
//
//  Created by Mac on 1/5/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptions: UITextView!
    func configure(property: Property) {
            title.text = property.title
        if property.data.count > 0 {
            self.descriptions.text = property.data[0].data
    }
    }

}
