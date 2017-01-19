//
//  SelectCategoryInteractor.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - SelectCategoryInteractor

final class SelectCategoryInteractor {

    // MARK: - VIPER stack

    weak var presenter: SelectCategoryInteractorOutput!
    fileprivate let dataManager: CategoryServiceProtocol
    // MARK: -
    
    init(dataManager: CategoryServiceProtocol) {
        self.dataManager = dataManager
    }
    
    convenience init() {
        self.init(dataManager: CategoryService())
    }


}

// MARK: - SelectCategoryInteractorInput

extension SelectCategoryInteractor: SelectCategoryInteractorInput {
    func fetchCategory() {
        dataManager.fetchCategory(result: {
            [weak self] result, error in
            if error == nil {
                self?.presenter.updateView(categoryList: result!)
            } else {
                let errorMassage = CustomError(code: error!).description
                self?.presenter.showAlert(error: errorMassage)
            }
        })
    }
}
