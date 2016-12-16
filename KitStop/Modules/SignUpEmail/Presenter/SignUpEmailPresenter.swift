//
//  SignUpEmailPresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SignUpEmailPresenter

final class SignUpEmailPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: SignUpEmailViewInput!
    var interactor: SignUpEmailInteractorInput!
    var router: SignUpEmailRouterInput!

}

// MARK: - SignUpEmailViewOutput

extension SignUpEmailPresenter: SignUpEmailViewOutput {

}

// MARK: - SignUpEmailInteractorOutput

extension SignUpEmailPresenter: SignUpEmailInteractorOutput {

}

// MARK: - SignUpEmailModuleInput

extension SignUpEmailPresenter: SignUpEmailModuleInput {

}
