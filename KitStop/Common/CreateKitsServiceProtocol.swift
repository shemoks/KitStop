//
//  CreateKitsServiceProtocol.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 1/16/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import Alamofire

protocol CreateKitsServiceProtocol {
    func createKit(kit: CreateKitsRequestBody, completion: @escaping (Bool, _ error: Int?, _ id: String?) -> ())
    func updateKit(id: String, kit: CreateKitsRequestBody, completion: @escaping (Bool, _ error: Int?, _ id: String?) -> ())

}


