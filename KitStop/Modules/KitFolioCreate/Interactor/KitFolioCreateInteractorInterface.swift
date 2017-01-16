//
//  KitFolioCreateInteractorInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - KitFolioCreateInteractorInput
import UIKit

protocol KitFolioCreateInteractorInput: class {
    func save(postTitle: String, postDescription: String, smallImage: UIImage?, bigImage: UIImage?)
}
