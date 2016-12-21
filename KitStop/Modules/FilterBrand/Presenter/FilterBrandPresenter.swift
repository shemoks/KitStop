//
//  FilterBrandPresenter.swift
//  KitStop
//
//  Created by Shemshur Oksana on 20/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - FilterBrandPresenter

final class FilterBrandPresenter {

    // MARK: - VIPER stack

    weak var moduleOutput: ModuleOutput?
    weak var view: FilterBrandViewInput!
    var interactor: FilterBrandInteractorInput!
    var router: FilterBrandRouterInput!
    var brands = [FilterItems]()

}

// MARK: - FilterBrandViewOutput

extension FilterBrandPresenter: FilterBrandViewOutput {

    func brandList() -> [FilterItems] {
        return self.brands
    }

    func selectedBrands(brands: [FilterItems]) {
        let filterBrandModuleOutput = moduleOutput as! FilterBrandModuleOutput
        filterBrandModuleOutput.selectedBrands(brands: brands)
        router.returnToFilters()
    }

//    func handleViewDidLoad(brands: [FilterItems]) {
//        view.getBrands(brands: self.brands)
//    }

}


// MARK: - FilterBrandInteractorOutput

extension FilterBrandPresenter: FilterBrandInteractorOutput {

}

// MARK: - FilterBrandModuleInput

extension FilterBrandPresenter: FilterBrandModuleInput {

    func setBrands(brands: [FilterItems]) {
        self.brands = brands
    }
}
