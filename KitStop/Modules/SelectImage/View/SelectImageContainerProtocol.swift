//
//  SelectImageContainerProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 04.01.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import UIKit

protocol SelectImageContainerProtocol {
    func changeContainer(_ height: CGFloat)
    func passImage(small: UIImage, big: UIImage)
}
