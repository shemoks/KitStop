//
//  KitFolioDetailedServiceProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 16.01.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import UIKit

protocol KitFolioDetailedServiceProtocol {
    func fetchKit(id: String, completitionBlock: @escaping (Product?, _ user: User?, _ error: Int?) -> ())
    func deleteKitFolio(id: String, completitionBlock: @escaping (_ error: Int?) -> ())
    func saveKitFolio(id: String, imageArray: [String], data: [String : String] , mainImage: String, completitionBlock: @escaping (Product?, _ error: Int?) -> ())
}
