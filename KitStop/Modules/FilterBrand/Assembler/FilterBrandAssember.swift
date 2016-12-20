//
//  FilterBrandAssember.swift
//  KitStop
//
//  Created by Shemshur Oksana on 20/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Foundation

// MARK: - FilterBrandAssembler

final class FilterBrandAssembler: NSObject {

    @IBOutlet weak var view: FilterBrandViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = FilterBrandInteractor()
        let presenter = FilterBrandPresenter()
        let router = FilterBrandRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
