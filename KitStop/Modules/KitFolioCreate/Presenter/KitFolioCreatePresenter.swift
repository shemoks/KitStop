//
//  KitFolioCreatePresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - KitFolioCreatePresenter

final class KitFolioCreatePresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: KitFolioCreateViewInput!
    var interactor: KitFolioCreateInteractorInput!
    var router: KitFolioCreateRouterInput!

}

// MARK: - KitFolioCreateViewOutput

extension KitFolioCreatePresenter: KitFolioCreateViewOutput {

}

// MARK: - KitFolioCreateInteractorOutput

extension KitFolioCreatePresenter: KitFolioCreateInteractorOutput {

}

// MARK: - KitFolioCreateModuleInput

extension KitFolioCreatePresenter: KitFolioCreateModuleInput {

}
