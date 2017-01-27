//
//  CustomButton.swift
//  KitStop
//
//  Created by Mac on 12/8/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit
import Foundation
@IBDesignable class CustomButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
        self.tintColor = UIColor(red: (107/255.0), green: (110/255.0), blue: (112/255.0), alpha: 1.0)
        
        self.titleLabel?.font = UIFont.init(name: "SFUIText-Regular", size: 17)
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }

    @IBInspectable var backGroundColor: UIColor {
        get {
            return UIColor(cgColor: layer.backgroundColor!)
        }
        set {
            layer.backgroundColor = newValue.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
}
