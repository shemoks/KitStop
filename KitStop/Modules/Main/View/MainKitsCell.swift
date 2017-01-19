//
//  MainKitsCell.swift
//  KitStop
//
//  Created by sasha ataman on 21.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit
import SDWebImage

class MainKitsCell: UICollectionViewCell {
    
    
    @IBOutlet weak var priceContainer: UIView!
    @IBOutlet weak var camera: UIImageView!
    @IBOutlet weak var cameraDescription: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var bottomMask: UIImageView!
    @IBOutlet weak var topMask: UIImageView!
    
    func setupCell(row: Int, kit: Product) {
        topMask.image = UIImage.init(named: "top_mask")
        bottomMask.image = UIImage.init(named: "bottom_mask")
        camera.sd_setImage(with: URL.init(string: kit.mainImage))
        cameraDescription.text = kit.title
        if let price = kit.salesDetails?.price {
            self.price.text = Double().checkNumberAfterDot(number: price)
            priceContainer.isHidden = false
        } else { priceContainer.isHidden = true }
    }
}
