//
//  CreateForSaleServiceProtocol.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 1/24/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import Alamofire

protocol CreateForSaleServiceProtocol {
    func createKit(kit: KitsForSaleRequestBody, completion: @escaping (Bool, _ error: Int?, _ id: String?) -> ())
}
