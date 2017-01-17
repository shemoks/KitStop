//
//  SelectCategoryRouterInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - SelectCategoryRouterInput

protocol SelectCategoryRouterInput: class {
    func openAddKitModule(categoryID: String, category: Bool)
}
