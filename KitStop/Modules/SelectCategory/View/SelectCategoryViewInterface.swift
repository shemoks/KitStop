//
//  SelectCategoryViewInterface.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

// MARK: - SelectCategoryViewInput

protocol SelectCategoryViewInput: class {
    func updateData(categoryList: [CategoryList])
    func showAlert(errorMassage: String)
}
