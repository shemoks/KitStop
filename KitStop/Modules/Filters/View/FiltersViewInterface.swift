//
//  FiltersViewInterface.swift
//  KitStop
//
//  Created by Shemshur Oksana on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

// MARK: - FiltersViewInput

protocol FiltersViewInput: class {
    
    func showError(title: String, message: String)
    func reloadData()
    func reloadPrice()
    func priceVisible(visible: Bool)
    func activeClearAll(isActive: Bool)
    func isVisiblePrice(result: Bool)
    
}
