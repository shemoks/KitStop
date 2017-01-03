//
//  CategoryServiceProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 03.01.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation

protocol CategoryServiceProtocol{
    func fetchCategory(result: @escaping ([CategoryList]?, _ error: Int?) -> ())
}
