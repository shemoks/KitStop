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
//        let newCategories = FilterManager().clearAll(categories: types)
//        presenter.setTypes(types: newCategories)
//        presenter.setPrice(price: Price(minValue: 0, maxValue: 1000000000))
//        presenter.setCurrentCategory(category: nil)
    }

//    func getPrice(category: Category) {
//        dataManager.getPrice(category: category) { [weak self] object, error in
//            if error == nil {
//                if (object.categoryPrice.maxValue != object.categoryPrice.minValue) {
//                    if object.categoryPrice.maxValue > 2000 {
//                    let newPrice = Price(minValue: object.categoryPrice.minValue, maxValue: 2000)
//                    self?.presenter.setPrice(price: newPrice)
//                    self?.presenter.isVisiblePriceSlider(isVisible: true)
//                    } else {
//                        self?.presenter.setPrice(price: object.categoryPrice)
//                        self?.presenter.isVisiblePriceSlider(isVisible: true)
//                    }
//                } else {
//                    if (object.categoryPrice.maxValue == object.categoryPrice.minValue) && object.categoryPrice.maxValue > 0 {
//                        let newPrice = Price(minValue: 0, maxValue:  object.categoryPrice.minValue)
//                        self?.presenter.setPrice(price: newPrice)
//                        self?.presenter.isVisiblePriceSlider(isVisible: true)
//                    } else {
//                    self?.presenter.showError(title: "Search results", message: "Not found")
//               //     self?.clearAll(types: categories)
//                    self?.presenter.isVisiblePriceSlider(isVisible: false)
//                    self?.presenter.setPrice(price: Price(minValue: 0, maxValue: 1000000000))
//                }
//                }
//
//            } else {
//                let error = CustomError(code: error!).description
//                self?.presenter.showError(title: "Error", message: error)
//                self?.presenter.setPrice(price: object.categoryPrice)
//            }
//        }
//    }

    func getPrice(category: Category) {
        dataManager.getPrice(category: category) { [weak self] object, error in
            if error == nil {
                print(object)
                if (object.categoryPrice.maxValue != object.categoryPrice.minValue) && object.categoryPrice.maxValue < 2000 {
                    self?.presenter.setPrice(price: object.categoryPrice)
                    self?.presenter.isVisibleSlider(isVisible: true)
                }
                if (object.categoryPrice.maxValue != object.categoryPrice.minValue) && object.categoryPrice.maxValue > 2000 {
                    let price = Price(minValue: object.categoryPrice.minValue, maxValue: 2000)
                    self?.presenter.isVisibleSlider(isVisible: true)
                    self?.presenter.setPrice(price: price)
                }
                if (object.categoryPrice.maxValue == object.categoryPrice.minValue) && object.categoryPrice.maxValue > 0 && object.categoryPrice.maxValue < 2000 {
                    let price = Price(minValue: 0, maxValue: object.categoryPrice.maxValue)
                    self?.presenter.isVisibleSlider(isVisible: true)
                    self?.presenter.setPrice(price: price)
                }
                if (object.categoryPrice.maxValue == object.categoryPrice.minValue) && object.categoryPrice.maxValue > 0 && object.categoryPrice.maxValue >= 2000 {
                    let price = Price(minValue: 0, maxValue: 2000)
                    self?.presenter.isVisibleSlider(isVisible: true)
                    self?.presenter.setPrice(price: price)
                }
                if (object.categoryPrice.maxValue == object.categoryPrice.minValue) && object.categoryPrice.maxValue == 0  {
                    self?.presenter.showError(title: "Search results", message: "Nothing found")
                    self?.presenter.isVisibleSlider(isVisible: false)
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
        FilterManager().getCurrentFilter(section: type) {result in
            let currentFilter = FilterModel()
            currentFilter.number = category.number
            currentFilter.title = category.title
            currentFilter.section = type
            currentFilter.minValue = price.minValue
            currentFilter.maxValue = price.maxValue
            FilterManager().saveFilter(filter: currentFilter)
            self.dataManager.getProducts(filter: filter) { [weak self] object, error in
                if error == nil {
                    self?.presenter.handleViewWillDisappear(kits: object.products)
                } else {
                    let error = CustomError(code: error!).description
                    self?.presenter.showError(title: "Error", message: error)
                }
            }
        }
    }

    func getCurrentFilter(section: Bool) {
        FilterManager().getCurrentFilter(section: section) { result in
            if result.count != 0 {
                let object = result.last
                let price = Price(minValue: (object?.minValue)!, maxValue: (object?.maxValue)!)
                self.presenter.setFilter(filter: object)
                self.presenter.setPrice(price: price)
            } else {
                self.presenter.setFilter(filter: nil)
            }
        }
    }

    func updateFilter(filter: FilterModel, currentFilter: CurrentFilter) {
        FilterManager().updateFilter(filter: filter, currentFilter: currentFilter)
    }

    func writeFilter(filter: FilterModel) {
        FilterManager().saveFilter(filter: filter)
    }

}

