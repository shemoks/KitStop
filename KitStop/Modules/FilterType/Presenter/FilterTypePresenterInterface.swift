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

    func categoryList() -> [FilterItems]

}

// MARK: - FilterTypeInteractorOutput

protocol FilterTypeInteractorOutput: class {

}

// MARK: - FilterTypeModuleInput

protocol FilterTypeModuleInput: ModuleInput {

    func setCategories(categories: [FilterItems])

}

// MARK: - FilterTypeModuleOutput

protocol FilterTypeModuleOutput: ModuleOutput {

    func currentCategory(category: FilterItems)

}
