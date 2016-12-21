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

    // MARK: -

}

// MARK: - FiltersInteractorInput

extension FiltersInteractor: FiltersInteractorInput {

    func getFilters() {
        let filter = FilterParametersService()
        filter.filterResult = {obj in
            if obj.error == nil {
                let brand1 = FilterItems()
                brand1.id = 1
                brand1.title = "Canon"
                brand1.type = .brand
                let brand2 = FilterItems()
                brand1.id = 2
                brand1.title = "Epson"
                brand1.type = .brand
                let category1 = FilterItems()
                category1.id = 1
                category1.title = "Cameras"
                category1.brands = [brand1, brand2]
                let category2 = FilterItems()
                category2.id = 2
                category2.title = "accessory"
                self.presenter.setBrands(brands: [brand1, brand2])
                self.presenter.setTypes(types: [category1, category2])
                self.presenter.setPrice(price: obj.filter.priceFilter)
//                self.presenter.setBrands(brands: obj.filter.brandFilter)
//                self.presenter.setTypes(types: obj.filter.typeFilter)
//                self.presenter.setPrice(price: obj.filter.priceFilter)
            } else {
                self.presenter.showError(title: "No Internet Connection", message: "Make sure your device is connected to the internet.")
            }
        }
        filter.getFilters()
    }

    func isTypesExist(types: [FilterItems]) -> Bool {
        if types.count != 0 {
            return true
        }
        return false
    }

    func clearAll(types: [FilterItems], brands: [FilterItems]) {
        var category = [FilterItems]()
        var brand = [FilterItems]()
        for filter in types {
            filter.isSelected = false
            category.append(filter)
        }
        for filter in brands {
            filter.isSelected = false
            brand.append(filter)
        }
        presenter.setBrands(brands: brand)
        presenter.setTypes(types: category)
        presenter.setPrice(price: Price(minValue: 0, maxValue: 100))
    }

    func getBrandsInCategory(category: String) {
//        let filter = FilterParametersService()
//        filter.filterResult = {obj in
//            if obj.error == nil {
//
//            }
//        }
    }
}
