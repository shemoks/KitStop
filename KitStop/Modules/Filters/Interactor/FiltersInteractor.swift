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
//                for category in obj.filter {
//                    
//                }
//                let category1 = FilterItems()
//                category1.id = 1
//                category1.title = "Cameras"
//                category1.isSelected = true
//                let category2 = FilterItems()
//                category2.id = 2
//                category2.title = "accessory"
//                self.presenter.setTypes(types: [category1, category2])
//                self.presenter.setPrice(price: obj.filter.priceFilter)
//
//                self.presenter.setBrands(brands: obj.filter.brandFilter)
//                self.presenter.setTypes(types: obj.filter.typeFilter)
//                self.presenter.setPrice(price: obj.filter.priceFilter)
            } else {
                self.presenter.showError(title: "No Internet Connection", message: "Make sure your device is connected to the internet.")
            }
        }
//        filter.getFilters()
    }

    func clearAll(types: [FilterItems]) {
        var category = [FilterItems]()
        for filter in types {
            filter.isSelected = false
            category.append(filter)
        }
        presenter.setTypes(types: category)
        presenter.setPrice(price: Price(minValue: 0, maxValue: 100))
    }

}
