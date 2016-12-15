//
//  RegistrationAssember.swift
//  KitStop
//
//  Created by Shemshur Oksana on 13/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Foundation

// MARK: - RegistrationAssembler

final class RegistrationAssembler: NSObject {

    @IBOutlet weak var view: RegistrationViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = RegistrationInteractor()
        let presenter = RegistrationPresenter()
        let router = RegistrationRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }
    
}
