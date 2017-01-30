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
        contents.placeholder = detail.placeholder
        
        if detail.isEditable! {
            contents.isEnabled = true
        }
        if detail.isExpandable! {
            self.accessoryType = .disclosureIndicator
        }
        if detail.isReady! {
            if detail.isValid! {
                self.backgroundColor = .white
            } else {
                self.backgroundColor = UIColor(colorLiteralRed: 245.0/255.0, green: 208.0/255.0, blue: 208.0/255.0, alpha: 1.0)
            }
        }
  
        if !(detail.value?.isEmpty)! {
            contents.text = detail.value
        }
    }
}
