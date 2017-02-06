//
//  FiltersInteractorInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - FiltersInteractorInput

protocol FiltersInteractorInput: class {

    func getFilters()
    func clearAll(filter: FilterModel)
    func getPrice(category: Category, price: @escaping () -> ())
    func getProducts(category: Category, price: Price, type: Bool)
    func getCurrentFilter(section: Bool)
    func updateFilter(filter: FilterModel, currentFilter: CurrentFilter)
    func writeFilter(filter: FilterModel)

}
