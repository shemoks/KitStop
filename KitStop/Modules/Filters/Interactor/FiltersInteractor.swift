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
        dataManager.categoryFromServer() { [weak self] object, error in
            if error == nil {
                self?.presenter.setTypes(types: object)
            } else {
                let error = CustomError(code: error!).description
                self?.presenter.showError(title: "Error", message: error)
                self?.presenter.setTypes(types: object)
            }
        }
    }

    func clearAll(types: [Category]) {
        let newCategories = FilterManager().clearAll(categories: types)
        presenter.setTypes(types: newCategories)
        presenter.setPrice(price: Price(minValue: 0, maxValue: 1000000000))
        presenter.setCurrentCategory(category: nil)
    }

    func getPrice(category: Category, categories: [Category]) {
        dataManager.getPrice(category: category) { [weak self] object, error in
            if error == nil {
                print(object)
                if (object.categoryPrice.maxValue != object.categoryPrice.minValue) && object.categoryPrice.maxValue < 2000 {
                    self?.presenter.setPrice(price: object.categoryPrice)
                }
                if (object.categoryPrice.maxValue != object.categoryPrice.minValue) && object.categoryPrice.maxValue > 2000 {
                    let price = Price(minValue: object.categoryPrice.minValue, maxValue: 2000)
                    self?.presenter.setPrice(price: price)
                }
                if (object.categoryPrice.maxValue == object.categoryPrice.minValue) && object.categoryPrice.maxValue > 0 && object.categoryPrice.maxValue < 2000 {
                    let price = Price(minValue: 0, maxValue: object.categoryPrice.maxValue)
                    self?.presenter.setPrice(price: price)
                }
                if (object.categoryPrice.maxValue == object.categoryPrice.minValue) && object.categoryPrice.maxValue > 0 && object.categoryPrice.maxValue >= 2000 {
                    let price = Price(minValue: 0, maxValue: 2000)
                    self?.presenter.setPrice(price: price)
                }
                if (object.categoryPrice.maxValue == object.categoryPrice.minValue) && object.categoryPrice.maxValue == 0  {
                    self?.presenter.showError(title: "Search results", message: "Nothing found")
                    self?.clearAll(types: categories)
                }
            } else {
                let error = CustomError(code: error!).description
                self?.presenter.showError(title: "Error", message: error)
                self?.presenter.setPrice(price: object.categoryPrice)
            }
        }
    }

    func getProducts(category: Category, price: Price, type: Bool) {
        let filter = Filter(idCategory: category.number, title: category.title, minPrice: price.minValue, maxPrice: price.maxValue, type: type)
        dataManager.getProducts(filter: filter) { [weak self] object, error in
            if error == nil {
                self?.presenter.handleViewWillDisappear(kits: object.products)
            } else {
                let error = CustomError(code: error!).description
                self?.presenter.showError(title: "Error", message: error)
            }
        }
    }
    
}
