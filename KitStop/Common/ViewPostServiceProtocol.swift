//
//  ViewPostServiceProtocol.swift
//  KitStop
//
//  Created by Mac on 1/17/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

protocol ViewPostServiceProtocol {

    func getAllKits(idKit: String, forSale: Bool, postValue: @escaping ((Post, _ errorCode: Int?) -> ()))
    func getAllKitsForSale(idKit: String, forSale: Bool, postValue: @escaping ((Post, _ errorCode: Int?) -> ()))
    func removeKit(idKit: String, completitionBlock: @escaping (Int?) -> ())
    func removeKitForSale(idKit: String, completitionBlock: @escaping (Int?) -> ())
    
}
