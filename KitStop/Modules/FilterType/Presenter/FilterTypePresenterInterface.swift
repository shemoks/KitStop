//
//  FilterTypePresenterInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 20/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - FilterTypeViewOutput

protocol FilterTypeViewOutput: class {

    func category(for indexPath: IndexPath) -> Category
    func numberOfCategories() -> Int
    func returnCategory(category: Category)

}

// MARK: - FilterTypeInteractorOutput

protocol FilterTypeInteractorOutput: class {

}

// MARK: - FilterTypeModuleInput

protocol FilterTypeModuleInput: ModuleInput {

    func setCategories(categories: [Category])

}

// MARK: - FilterTypeModuleOutput

protocol FilterTypeModuleOutput: ModuleOutput {

    func currentCategory(currentCategory: Category)

}
