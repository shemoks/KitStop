//
//  KitAdditionalInforPrivacyCell.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 1/17/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

class KitAdditionalInfoPrivacyCell:UITableViewCell {
    
    func configure() {
        self.accessoryType = UITableViewCellAccessoryType.checkmark
        self.tintColor = UIColor(red: 255.0/255.0, green: 136.0/255.0, blue: 48.0/255.0, alpha: 1.0)
    }
}
