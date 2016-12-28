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
    
    func setupCell(row: Int, kit: KitsModel) {
        camera.sd_setImage(with: URL.init(string: kit.mainImage))
        cameraDescription.text = kit.title
        if let price = kit.price {
            self.price.text = "\(price)"
            priceContainer.isHidden = false
        } else { priceContainer.isHidden = true }
    }
}
