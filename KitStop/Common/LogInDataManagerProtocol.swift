//
//  LogInDataManagerProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 05.01.17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol LogInDataManagerProtocol {
    func saveUserData(json: JSON)
    func getUserFromRealm() -> User?
}
