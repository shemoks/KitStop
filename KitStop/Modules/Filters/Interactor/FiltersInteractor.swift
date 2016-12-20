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

    func getBrands(currentFilter: Filter) {
        presenter.setBrands(brands: [])
    }

    func getTypes(currentFilter: Filter) {
        presenter.setTypes(types: [])
    }

    func getFilters() {
        let filter = FilterParametersService()
        filter.filterResult = {obj in
            if obj.error == nil {
                self.presenter.setBrands(brands: obj.filter.brandFilter)
                self.presenter.setTypes(types: obj.filter.typeFilter)
                self.presenter.setPrice(price: obj.filter.priceFilter)
            } else {
                self.presenter.showError(title: "No Internet Connection", message: "Make sure your device is connected to the internet.")
            }
        }
        filter.getFilters()
    }
}
