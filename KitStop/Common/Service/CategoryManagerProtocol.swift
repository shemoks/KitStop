//
//  DataManagerProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 19.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation

protocol CategoryManagerProtocol {

    func categoryFromServer(arrayOfCategories: @escaping (([Category]) -> ()))
    func getProducts(filter: Filter)
    func getPrice(category: Category, result: @escaping ((CategoryPrice) -> ()))

}
