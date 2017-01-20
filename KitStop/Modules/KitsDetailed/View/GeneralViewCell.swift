//
//  GeneralViewCell.swift
//  KitStop
//
//  Created by Mac on 1/18/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

class GeneralViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var data: UITextField!

    func configure(property: ViewProperty) {

        title.text = property.title
        data.text = property.text
        data.isUserInteractionEnabled = false
    }
}
