//
//  KitsDetailedAssember.swift
//  KitStop
//
//  Created by Shemshur Oksana on 18/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - KitsDetailedAssembler

final class KitsDetailedAssembler: NSObject {

    @IBOutlet weak var view: KitsDetailedViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = KitsDetailedInteractor()
        let presenter = KitsDetailedPresenter()
        let router = KitsDetailedRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
