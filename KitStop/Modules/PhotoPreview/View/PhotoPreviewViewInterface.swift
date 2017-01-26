//
//  PhotoPreviewViewInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 24/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - PhotoPreviewViewInput
import UIKit

protocol PhotoPreviewViewInput: class {
    func handleImage(image: UIImage, isEditMode: Bool)
}
