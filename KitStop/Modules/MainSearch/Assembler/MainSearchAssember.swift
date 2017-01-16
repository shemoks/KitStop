//
//  MainSearchAssember.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - MainSearchAssembler

final class MainSearchAssembler: NSObject {

    @IBOutlet weak var view: MainSearchViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = MainSearchInteractor()
        let presenter = MainSearchPresenter()
        let router = MainSearchRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
