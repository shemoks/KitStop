//
//  SelectCategoryPresenterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - SelectCategoryViewOutput

protocol SelectCategoryViewOutput: class {
    func fetchCategory()
    func openAddItemModule(categoryID: String)
}

// MARK: - SelectCategoryInteractorOutput

protocol SelectCategoryInteractorOutput: class {
    func updateView(categoryList: [CategoryList])
    func showAlert(error: String)
}

// MARK: - SelectCategoryModuleInput

protocol SelectCategoryModuleInput: ModuleInput {

}

// MARK: - SelectCategoryModuleOutput

protocol SelectCategoryModuleOutput: ModuleOutput {

}
