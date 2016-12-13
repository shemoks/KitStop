//
//  CustomImage.swift
//  KitStop
//
//  Created by Mac on 12/13/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit

@IBDesignable
class CircularImageView: UIView {

    var backgroundLayer: CAShapeLayer!
    var imageLayer: CALayer!
    var userImage: UIImage?
    @IBInspectable var backgroundLayerColor: UIColor = UIColor.gray
    @IBInspectable var lineWidth: CGFloat = 1.0
    @IBInspectable var image: UIImage?

    override func layoutSubviews() {
        super.layoutSubviews()
        setBackgroundLayer()
        setBackgroundImageLayer()
        setImage()
    }

    func setBackgroundLayer() {
        if backgroundLayer == nil {
            backgroundLayer = CAShapeLayer()
            layer.addSublayer(backgroundLayer)
            let rect = bounds.insetBy(dx: lineWidth / 2.0, dy: lineWidth / 2.0)
            let path = UIBezierPath(ovalIn: rect)
            backgroundLayer.path = path.cgPath
            backgroundLayer.lineWidth = lineWidth
            backgroundLayer.fillColor = backgroundLayerColor.cgColor
        }
        backgroundLayer.frame = layer.bounds
    }

    func setBackgroundImageLayer() {

        if imageLayer == nil {
            let mask = CAShapeLayer()
            let dx = lineWidth + 3.0
            let path = UIBezierPath(ovalIn: self.bounds.insetBy(dx: dx, dy: dx))
            mask.fillColor = UIColor.black.cgColor
            mask.path = path.cgPath
            mask.frame = self.bounds
            layer.addSublayer(mask)
            imageLayer = CAShapeLayer()
            imageLayer.frame = self.bounds
            imageLayer.mask = mask
            imageLayer.contentsGravity = kCAGravityResizeAspectFill
            layer.addSublayer(imageLayer)
        }
    }

    func setImage() {
        if imageLayer != nil {
            if let userPic = userImage {
                imageLayer.contents = userPic.cgImage
            } else {
                if let pic = image {
                    imageLayer.contents = pic.cgImage
                }
            }
        }
    }
}
