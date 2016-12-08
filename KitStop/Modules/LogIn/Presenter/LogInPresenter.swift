//
//  LogInPresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 08/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - LogInPresenter

final class LogInPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: LogInViewInput!
    var interactor: LogInInteractorInput!
    var router: LogInRouterInput!

}

// MARK: - LogInViewOutput

extension LogInPresenter: LogInViewOutput {

}

// MARK: - LogInInteractorOutput

extension LogInPresenter: LogInInteractorOutput {

}

// MARK: - LogInModuleInput

extension LogInPresenter: LogInModuleInput {

}
