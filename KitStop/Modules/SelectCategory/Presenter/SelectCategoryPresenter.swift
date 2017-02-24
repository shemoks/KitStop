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
    var caseOf: ReturnCase = .main
    fileprivate var category: Bool?

}

// MARK: - SelectCategoryViewOutput

extension SelectCategoryPresenter: SelectCategoryViewOutput {

    func fetchCategory() {
        interactor.fetchCategory()
    }

    func openMainModule() {
        router.openMainModule()
    }

}

// MARK: - SelectCategoryInteractorOutput

extension SelectCategoryPresenter: SelectCategoryInteractorOutput {

    func updateView(categoryList: [CategoryList]) {
        view.updateData(categoryList: categoryList)
    }

    func showAlert(error: String) {
        view.showAlert(errorMassage: error)
    }

    func openAddItemModule(categoryID: String) {
        router.openAddKitModule(categoryID: categoryID, category: category!, returnCase: self.caseOf)
    }

}

// MARK: - SelectCategoryModuleInput

extension SelectCategoryPresenter: SelectCategoryModuleInput {

    func handleCategory(category: Bool) {
        self.category = category
    }

    func returnCase(caseOf: ReturnCase) {
        self.caseOf = caseOf
    }
    
}
