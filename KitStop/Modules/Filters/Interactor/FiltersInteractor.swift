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
        dataManager.categoryFromServer() {object, error in
            if error == nil {
                self.presenter.setTypes(types: object)
            } else {
                let error = CustomError(code: error!).description
                self.presenter.showError(title: "Error", message: error)
                self.presenter.setTypes(types: object)
            }
        }
    }

    func clearAll(types: [Category]) {
        let newCategories = FilterManager().clearAll(categories: types)
        presenter.setTypes(types: newCategories)
        presenter.setPrice(price: Price(minValue: 0, maxValue: 100))
        presenter.setCurrentCategory(category: nil)
    }

    func getPrice(category: Category) {
        dataManager.getPrice(category: category) {object, error in
            if error == nil {
                if object.categoryPrice.maxValue != object.categoryPrice.minValue {
                    self.presenter.setPrice(price: object.categoryPrice)
                } else {
                    self.presenter.setPrice(price: Price(minValue: 0, maxValue: 100))
                }

            } else {
                let error = CustomError(code: error!).description
                self.presenter.showError(title: "Error", message: error)
                self.presenter.setPrice(price: object.categoryPrice)
            }
        }
    }

    func getProducts(category: Category, price: Price, type: Bool) {
        let filter = Filter(idCategory: category.number, title: category.title, minPrice: price.minValue, maxPrice: price.maxValue, type: type)
        dataManager.getProducts(filter: filter) { object, error in
            if error == nil {
                self.presenter.handleViewWillDisappear(kits: object.products)
            } else {
                let error = CustomError(code: error!).description
                self.presenter.showError(title: "Error", message: error)
            }
        }
    }
    
}
