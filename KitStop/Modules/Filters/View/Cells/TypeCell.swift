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
        var labelText = "Select filter"
        if !filter.isEmpty {
        for item in filter {
            labelText = labelText + item.title + "  "
        }
        }
        titleLabel.text = labelText
    }
}
