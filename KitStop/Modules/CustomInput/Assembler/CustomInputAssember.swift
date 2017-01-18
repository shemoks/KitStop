//
//  CustomInputAssember.swift
//  KitStop
//
//  Created by Shemshur Oksana on 13/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - CustomInputAssembler

final class CustomInputAssembler: NSObject {

    @IBOutlet weak var view: CustomInputViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = CustomInputInteractor()
        let presenter = CustomInputPresenter()
        let router = CustomInputRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
