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
    func clearAll(types: [FilterItems])

}
