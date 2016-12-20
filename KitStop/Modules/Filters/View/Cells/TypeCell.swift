//
//  TypeCell.swift
//  KitStop
//
//  Created by Mac on 12/15/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit

class TypeCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    func configure(filter: [FilterItems]) {
        let clearFilter = "Select filter"
        var labelText = ""
        if !filter.isEmpty {
            for item in filter {
                if item.isSelected == true {
                    labelText = labelText + item.title + "  "
                }
            }
        }
        if labelText == "" {
            titleLabel.text = clearFilter
        } else {
            titleLabel.text = labelText
        }
    }
}
