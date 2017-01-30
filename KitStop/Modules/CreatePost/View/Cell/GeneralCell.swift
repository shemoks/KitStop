//
//  GeneralCell.swift
//  KitStop
//
//  Created by Mac on 1/5/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

class GeneralCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var title: UILabel!

    @IBOutlet weak var data: UITextField!
    var object: Property?
    var result: Product!
    func configure(property: Property) {

        self.accessoryType = .none
        data.isEnabled = true

        self.object = property

        if property.isValidate == false {
            self.layer.backgroundColor = UIColor(red: (253/255.0), green: (169/255.0), blue: (131/255.0), alpha: 1.0).cgColor
        } else {
            self.layer.backgroundColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 1.0).cgColor
        }
        title.text = property.title
        data.text = property.textValue
        if  property.placeholder != nil {
            data.placeholder = property.placeholder!
        }
        if property.isSelect == true {
            self.accessoryType = .disclosureIndicator
            data.isEnabled = false
        }

//        if  property.isSelect && property.currentData == nil {
//            self.accessoryType = .disclosureIndicator
//            data.isEnabled = true
//            if  property.placeholder != nil {
//                data.placeholder = property.placeholder!
//            }
//            data.isEnabled = false
//        }
//
//        if  property.isSelect && (property.currentData != nil) {
//            self.accessoryType = .disclosureIndicator
//            data.isEnabled = true
//            if  property.placeholder != nil {
//                data.placeholder = property.placeholder!
//            }
//            self.data.text = property.currentData
//            data.isEnabled = false
//            self.object?.isValidate = true
//            self.layer.backgroundColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 1.0).cgColor
//        }
        data.delegate = self
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.object?.textValue = textField.text!
        if validation(data: (self.object?.textValue)!) {
            self.object?.isValidate = true
            self.layer.backgroundColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 1.0).cgColor
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.characters.count - range.length
        if let limit = object?.limit {
            return newLength <= limit
        } else {
            return newLength <= 255
        }
    }

    func validation(data: String) -> Bool {
        let newData = data.trimmingCharacters(in: .whitespaces)
        if data.characters.count > 0 && newData.characters.count > 0 {
            return true
        }
        return false
    }
    
}
