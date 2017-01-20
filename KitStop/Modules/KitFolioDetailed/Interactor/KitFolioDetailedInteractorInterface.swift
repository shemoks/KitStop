//
//  KitFolioDetailedInteractorInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - KitFolioDetailedInteractorInput
import UIKit

protocol KitFolioDetailedInteractorInput: class {
    func fetchKitFrom(id: String?)
    func delete(id: String)
    func save(images: [UIImage?], data: [String : String], id: String, mainImage: UIImage?)
    func update(data: [String : String], id: String, mainImage: String)
}
