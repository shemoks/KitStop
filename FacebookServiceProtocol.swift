//
//  FacebookService.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 12/30/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol FacebookServiceProtocol {
    func authenticateUser(token: String, completion: @escaping (Bool, _ json: JSON?) -> ())
}
