//
//  UserInformationPresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - UserInformationPresenter

final class UserInformationPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: UserInformationViewInput!
    var interactor: UserInformationInteractorInput!
    var router: UserInformationRouterInput!

}

// MARK: - UserInformationViewOutput

extension UserInformationPresenter: UserInformationViewOutput {

}

// MARK: - UserInformationInteractorOutput

extension UserInformationPresenter: UserInformationInteractorOutput {

}

// MARK: - UserInformationModuleInput

extension UserInformationPresenter: UserInformationModuleInput {

}
