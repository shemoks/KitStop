//
//  SaleInfoCell.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 1/5/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

class SaleInfoCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var contents: UITextField!
    
    func configure(detail: ForSaleDetailsModel) {
        title.text = detail.header
        title.placeholderText = detail.placeholder
        if detail.isEditable! {
            contents.isEnabled = true
        }
        if detail.isExpandable! {
            self.accessoryType = .disclosureIndicator
        }
    }
}
