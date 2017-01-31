//
//  PhotoCellNew.swift
//  KitStop
//
//  Created by Mac on 1/30/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import UIKit

class PhotoCellNew: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    func configure(typeImage: PostImagesModel.CellImage) {
        switch  typeImage  {
        case .Required:
            photo.image = UIImage.init(named: "required")
        case .Add:
            photo.image = UIImage.init(named: "cameraForSave")
        case .Actual(let image):
             photo.image = image
        case .Remote(let url):
            photo.sd_setImage(with: url)
        case .Blank:
            photo.image = UIImage.init(named: "blank1")

        }
}
}
