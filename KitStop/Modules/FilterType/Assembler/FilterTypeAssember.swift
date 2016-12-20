//
//  FilterTypeAssember.swift
//  KitStop
//
//  Created by Shemshur Oksana on 20/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Foundation

// MARK: - FilterTypeAssembler

final class FilterTypeAssembler: NSObject {

    @IBOutlet weak var view: FilterTypeViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = FilterTypeInteractor()
        let presenter = FilterTypePresenter()
        let router = FilterTypeRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
