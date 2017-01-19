//
//  CreateKitSaveAssember.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - CreateKitSaveAssembler

final class CreateKitSaveAssembler: NSObject {

    @IBOutlet weak var view: CreateKitSaveViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = CreateKitSaveInteractor()
        let presenter = CreateKitSavePresenter()
        let router = CreateKitSaveRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
