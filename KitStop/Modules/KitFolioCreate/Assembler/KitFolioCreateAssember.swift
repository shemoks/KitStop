//
//  KitFolioCreateAssember.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - KitFolioCreateAssembler

final class KitFolioCreateAssembler: NSObject {

    @IBOutlet weak var view: KitFolioCreateViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = KitFolioCreateInteractor()
        let presenter = KitFolioCreatePresenter()
        let router = KitFolioCreateRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
