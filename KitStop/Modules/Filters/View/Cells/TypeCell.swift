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

    func configure(filter: String) {

    titleLabel.text = filter
}

}
