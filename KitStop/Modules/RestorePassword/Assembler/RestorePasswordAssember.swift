//
//  RestorePasswordAssember.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 19/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Foundation

// MARK: - RestorePasswordAssembler

final class RestorePasswordAssembler: NSObject {

    @IBOutlet weak var view: RestorePasswordViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = RestorePasswordInteractor()
        let presenter = RestorePasswordPresenter()
        let router = RestorePasswordRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
