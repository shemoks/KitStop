//
//  CreateSaleConfirmAssember.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - CreateSaleConfirmAssembler

final class CreateSaleConfirmAssembler: NSObject {

    @IBOutlet weak var view: CreateSaleConfirmViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = CreateSaleConfirmInteractor()
        let presenter = CreateSaleConfirmPresenter()
        let router = CreateSaleConfirmRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
