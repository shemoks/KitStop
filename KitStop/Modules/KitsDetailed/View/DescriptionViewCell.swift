//
//  DescriptionViewCell.swift
//  KitStop
//
//  Created by Mac on 1/18/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//
import UIKit

class DescriptionViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptions: UITextView!

    func configure(property: Property) {
        title.text = property.title

        if property.textValue != "" {
        descriptions.text = property.textValue
        } else {
            //        self.descriptions.textColor = UIColor(red: (151/255.0), green: (153/255.0), blue: (155/255.0), alpha: 1.0)
            descriptions.text = "No " + property.title
        }
        self.isUserInteractionEnabled = false
    }

}
