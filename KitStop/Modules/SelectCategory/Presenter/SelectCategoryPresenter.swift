//
//  SelectCategoryPresenter.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SelectCategoryPresenter

final class SelectCategoryPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: SelectCategoryViewInput!
    var interactor: SelectCategoryInteractorInput!
    var router: SelectCategoryRouterInput!

}

// MARK: - SelectCategoryViewOutput

extension SelectCategoryPresenter: SelectCategoryViewOutput {

}

// MARK: - SelectCategoryInteractorOutput

extension SelectCategoryPresenter: SelectCategoryInteractorOutput {

}

// MARK: - SelectCategoryModuleInput

extension SelectCategoryPresenter: SelectCategoryModuleInput {

}
