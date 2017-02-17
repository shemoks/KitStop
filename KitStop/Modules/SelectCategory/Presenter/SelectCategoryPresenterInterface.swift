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
    func openMainModule()
}

// MARK: - SelectCategoryInteractorOutput

protocol SelectCategoryInteractorOutput: class {
    func updateView(categoryList: [CategoryList])
    func showAlert(error: String)
}

// MARK: - SelectCategoryModuleInput

protocol SelectCategoryModuleInput: ModuleInput {
    func handleCategory(category: Bool)
    func returnCase(caseOf: ReturnCase)
}

// MARK: - SelectCategoryModuleOutput

protocol SelectCategoryModuleOutput: ModuleOutput {

}
