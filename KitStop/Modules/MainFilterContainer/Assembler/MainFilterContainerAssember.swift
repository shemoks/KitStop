//
//  MainFilterContainerAssember.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Foundation

// MARK: - MainFilterContainerAssembler

final class MainFilterContainerAssembler: NSObject {

    @IBOutlet weak var view: MainFilterContainerViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = MainFilterContainerInteractor()
        let presenter = MainFilterContainerPresenter()
        let router = MainFilterContainerRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
