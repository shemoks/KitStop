//
//  UnderConstructionAssember.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - UnderConstructionAssembler

final class UnderConstructionAssembler: NSObject {

    @IBOutlet weak var view: UnderConstructionViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = UnderConstructionInteractor()
        let presenter = UnderConstructionPresenter()
        let router = UnderConstructionRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
