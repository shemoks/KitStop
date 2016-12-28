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

    fileprivate let dataManager: FilterManagerProtocol
    // MARK: -

    init(dataManager: FilterManagerProtocol) {
        self.dataManager = dataManager
    }

    convenience init() {
        self.init(dataManager: FilterManager())
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
        let newCategories = FilterManager().clearAll(categories: types)
        presenter.setTypes(types: newCategories)
        presenter.setPrice(price: Price(minValue: 0, maxValue: 100))
    }

    func getPrice(category: Category) {
        dataManager.getPrice(category: category) {object in
            print(object)
            if object.categoryPrice.maxValue != object.categoryPrice.minValue {
            self.presenter.setPrice(price: object.categoryPrice)
            } else {
                self.presenter.setPrice(price: Price(minValue: 0, maxValue: 100))
            }
        }
    }

    func getProducts(category: Category, price: Price, type: Bool) {
        let filter = Filter(idCategory: category.number, title: category.title, minPrice: price.minValue, maxPrice: price.maxValue, type: type)
        dataManager.getProducts(filter: filter) { object in
            print(object)
      //return object in main
        }
    }

}
