//
//  FilterTypeInteractor.swift
//  KitStop
//
//  Created by Shemshur Oksana on 20/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//
import RealmSwift
// MARK: - FilterTypeInteractor

final class FilterTypeInteractor {
    let realm = try! Realm()

    // MARK: - VIPER stack

    weak var presenter: FilterTypeInteractorOutput!

    // MARK: -

}

// MARK: - FilterTypeInteractorInput

extension FilterTypeInteractor: FilterTypeInteractorInput {

    func changeCategories(categories: [Category], category: Category) -> [Category] {
        let newCategories = FilterManager().changeCategories(categories: categories, category: category)
        return newCategories
    }

}
