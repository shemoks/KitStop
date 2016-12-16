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
        //request to server
        presenter.setBrands(brands: [])
    }

    func getTypes(currentFilter: Filter) {
        //request to server
        presenter.setTypes(types: [])
    }

    func getPrice() {
        //request to server
        presenter.setPrice(price: Price(minValue: 0, maxValue: 0))
    }

}
