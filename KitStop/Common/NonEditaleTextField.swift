//
//  NonEditaleTextField.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 2/22/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

class NonEditableTextField: UITextField {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) || action == #selector(cut(_:)) || action == #selector(delete(_:)) {
            return false
        }
        
        return true
    }
}
