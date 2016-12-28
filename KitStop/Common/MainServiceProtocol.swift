//
//  MainServiceProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 27.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation

protocol MainServiceProtocol {
    func fetchAllKitFolio(page: Int, completionBlock: @escaping ([Product]) -> ())
    func fetchAllKits(page: Int, completionBlock: @escaping ([Product]) -> ())
    func fetchAllKitsForSale(page: Int, completionBlock: @escaping ([Product]) -> ())
}
