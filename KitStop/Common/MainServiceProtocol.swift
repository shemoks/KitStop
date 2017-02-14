//
//  MainServiceProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 27.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation
import UIKit

protocol MainServiceProtocol {
    func fetchAllKitFolio(page: Int, completionBlock: @escaping (_ error: Int?) -> ())
    func fetchAllKits(page: Int, filterButton: UIButton? , completionBlock: @escaping (_ error: Int?) -> ())
    func fetchAllKitsForSale(page: Int, filterButton: UIButton? , completionBlock: @escaping (_ error: Int?) -> ())
}
