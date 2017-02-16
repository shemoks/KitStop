//
//  TabBarAssember.swift
//  KitStop
//
//  Created by Shemshur Oksana on 14/02/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - TabBarAssembler

final class TabBarAssembler: NSObject {

    @IBOutlet weak var view: TabBarViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = TabBarInteractor()
        let presenter = TabBarPresenter()
        let router = TabBarRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
