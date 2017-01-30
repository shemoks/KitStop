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

    func configure(property: Property) {

        title.text = property.title
        if property.title  == "Purchase Date" {
            let value = Double(property.textValue)
            let dateFormatter = DateFormatter()
            let dateValue = Date(timeIntervalSince1970: TimeInterval(value!))
            dateFormatter.dateFormat = "dd MMM yyyy"
            dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
            let timeStamp = dateFormatter.string(from: dateValue)
            data.text = timeStamp
        } else {
            if property.title  == "Purchase Price" {
                let units = property.units
                if units == "USD" {
                    data.text = "$" + property.textValue
                }
            } else {
                data.text = property.textValue
            }
        }
        data.isUserInteractionEnabled = false
    }
}
