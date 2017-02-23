//
//  KitAdditionalInfoCell.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 1/16/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

class KitInfoCell: UITableViewCell {
    @IBOutlet weak var header: UILabel!
    
    @IBOutlet weak var value: NonEditableTextField!
    
    func configure(detail: KitDetailsModel) {
        header.text = detail.header
        value.text = detail.contents
        value.placeholder = detail.placeholder
    }
}
