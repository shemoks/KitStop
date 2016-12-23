//
//  CustomAvatar.swift
//  KitStop
//
//  Created by Mac on 12/13/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit

enum RoundingMode {
    case circle
    case withRadius(CGFloat)
}

class CustomAvatar: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        applyRounding(mode: .circle)
    }

}

extension UIView {
    
    func applyRounding(mode: RoundingMode) {
        let radius = radiusWith(mode: mode)
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    private func radiusWith(mode: RoundingMode) -> CGFloat {
        switch mode {
        case .circle:
            return self.bounds.size.width / 2.0
        case let .withRadius(value):
            return value
        }
    }
}
