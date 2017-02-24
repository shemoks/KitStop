//
//  CustomInputCell.swift
//  KitStop
//
//  Created by Mac on 1/13/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

class CustomInputCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var data: UITextField!
    var object: Other?
    var result: Product!

    func configure(property: Other) {
        if  property.placeholder != nil {
            data.placeholder = property.placeholder
        }
        data.text = property.data
        self.object = property
        data.delegate = self

    }

    override func awakeFromNib() {
        super.awakeFromNib()

        data.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)
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

    func didChangeText(textField: UITextField) {
        if let textInField = data.text {
            object?.data = textInField
        }
    }
    
}
