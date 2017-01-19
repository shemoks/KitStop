//
//  KitFolioDetailedServiceProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 16.01.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation

protocol KitFolioDetailedServiceProtocol {
    func fetchKit(id: String, completitionBlock: @escaping (Product?, _ user: User?, _ error: Int?) -> ())
}
