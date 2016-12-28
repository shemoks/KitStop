//
//  SignUpServiceProtocol.swift
//  KitStop
//
//  Created by sasha ataman on 24.12.16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import Foundation

protocol SignUpServiceProtocol {
    func addNewUser(email: String, password: String, photoUrl: String?, completionBlock: @escaping (Bool) -> ())
}
