//
//  RestorePasswordServiceProtocol.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 1/3/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation

protocol RestorePasswordServiceProtocol {
    func requestPasswordRecovery(email: String, completion: @escaping (Bool, _ error: Int?) -> ())
}
