//
//  PhotoCell.swift
//  KitStop
//
//  Created by Mac on 1/5/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var photo: UIImageView!
    func configure(image: UIImage) {
        photo.image = image
    }
    
}
