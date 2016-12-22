//
//  MainAssember.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Foundation

// MARK: - MainAssembler

final class MainAssembler: NSObject {

    @IBOutlet weak var view: MainViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
