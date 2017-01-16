//
//  CustomPasswordDelegate.swift
//  KitStop
//
//  Created by sasha ataman on 12.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation
import UIKit

@objc protocol CustomPasswordDelegateTextField {
    func tapOnPasswordImageSuccess(textField: UITextField)
    func openNextModule()
}
