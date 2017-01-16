//
//  UserInformationPresenterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - UserInformationViewOutput

protocol UserInformationViewOutput: class {
    func getUserInfo()
}

// MARK: - UserInformationInteractorOutput

protocol UserInformationInteractorOutput: class {
    func showUser(user: [String : String])
}

// MARK: - UserInformationModuleInput

protocol UserInformationModuleInput: ModuleInput {

}

// MARK: - UserInformationModuleOutput

protocol UserInformationModuleOutput: ModuleOutput {

}
