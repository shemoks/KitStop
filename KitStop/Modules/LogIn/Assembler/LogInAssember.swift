//
//  LogInAssember.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 08/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Foundation

// MARK: - LogInAssembler

final class LogInAssembler: NSObject {

    @IBOutlet weak var view: LogInViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = LogInInteractor()
        let presenter = LogInPresenter()
        let router = LogInRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
