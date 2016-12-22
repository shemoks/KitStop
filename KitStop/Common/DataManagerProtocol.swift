//
//  DataManagerProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 19.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
    func fetchUserInServer(email: String, password: String)
}
