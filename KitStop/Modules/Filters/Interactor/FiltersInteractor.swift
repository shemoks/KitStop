//
//  FiltersInteractor.swift
//  KitStop
//
//  Created by Shemshur Oksana on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - FiltersInteractor

final class FiltersInteractor {

    // MARK: - VIPER stack

    weak var presenter: FiltersInteractorOutput!

    fileprivate let dataManager: CategoryManagerProtocol
    // MARK: -

    init(dataManager: CategoryManagerProtocol) {
        self.dataManager = dataManager
    }

    convenience init() {
        self.init(dataManager: CategoryManager())
    }


}

    // MARK: - FiltersInteractorInput

extension FiltersInteractor: FiltersInteractorInput {

    func getFilters() {
        dataManager.categoryFromServer() {object in
            self.presenter.setTypes(types: object)
        }
    }

    func clearAll(types: [Category]) {
        let newCategories = CategoryManager().clearAll(categories: types)
        presenter.setTypes(types: newCategories)
        presenter.setPrice(price: Price(minValue: 0, maxValue: 100))
    }


    func getPrice(category: Category) {
        dataManager.getPrice(category: category) {object in
            self.presenter.setPrice(price: object.categoryPrice)
        }

    }

}
