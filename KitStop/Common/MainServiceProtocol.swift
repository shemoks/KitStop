//
//  MainServiceProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 27.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation

protocol MainServiceProtocol {
    func fetchAllKitFolio(page: Int, completionBlock: @escaping ([Product]?, _ error: Int?) -> ())
    func fetchAllKits(page: Int, completionBlock: @escaping ([Product]?, _ error: Int?) -> ())
    func fetchAllKitsForSale(page: Int, completionBlock: @escaping ([Product]?, _ error: Int?) -> ())
}
