//
//  FiltersAssember.swift
//  KitStop
//
//  Created by Shemshur Oksana on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Foundation

// MARK: - FiltersAssembler

final class FiltersAssembler: NSObject {

    @IBOutlet weak var view: FiltersViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = FiltersInteractor()
        let presenter = FiltersPresenter()
        let router = FiltersRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
