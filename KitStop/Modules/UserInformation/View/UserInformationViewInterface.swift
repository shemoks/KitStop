//
//  UserInformationViewInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - UserInformationViewInput

protocol UserInformationViewInput: class {
    func showUser(user: [String : String])
}
