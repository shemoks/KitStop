//
//  DataManagerProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 19.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation

protocol FilterManagerProtocol {

    func categoryFromServer(arrayOfCategories: @escaping (([Category], _ errorCode: Int?) -> ()))
    func getProducts(filter: Filter, result: @escaping ((FilterResult,_ errorCode: Int?) -> ()))
    func getPrice(category: Category, result: @escaping ((CategoryPrice, _ errorCode: Int?) -> ()))

}
