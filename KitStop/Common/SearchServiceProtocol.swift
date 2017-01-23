//
//  SearchServiceProtocol.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 1/4/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import Alamofire

protocol SearchServiceProtocol {
    func fetchKitFolioSearchResults(page: Int, title: String, completion: @escaping ([Product], _ error: Int?, _ kitsFound: Bool) -> ())
    func fetchKitsSearchResults(page: Int, title: String, completion: @escaping ([Product], _ error: Int?,  _ kitsFound: Bool) -> ())
    func fetchKitsForSaleSearchResults(page: Int, title: String, completion: @escaping ([Product], _ error: Int?, _ kitsFound: Bool) -> ())
}
