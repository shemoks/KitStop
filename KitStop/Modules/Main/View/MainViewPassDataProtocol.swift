//
//  MainViewPassDataProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 06.01.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation

protocol MainViewPassDataProtocol {
    func passData(selectedItem: Int)
    func selectedKits(kitId: String, ownerId: String)
    func refreshKits()
    func fetchKits()
}
