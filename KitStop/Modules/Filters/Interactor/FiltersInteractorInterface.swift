//
//  FiltersInteractorInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - FiltersInteractorInput

protocol FiltersInteractorInput: class {

    func getFilters(completion: @escaping () -> ())
    func clearAll(types: [Category])
    func getPrice(category: Category)
    func getProducts(category: Category, price: Price, type: Bool)
    func getCurrentFilter(type: [Category], section: Bool, completion: @escaping (Bool) -> ())

}
