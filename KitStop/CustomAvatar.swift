//
//  CustomAvatar.swift
//  KitStop
//
//  Created by Mac on 12/13/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit

class CustomAvatar: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }

}
