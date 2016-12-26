//
//  RegistrationTakePhotoAssember.swift
//  KitStop
//
//  Created by Shemshur Oksana on 12/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Foundation

// MARK: - RegistrationTakePhotoAssembler

final class RegistrationTakePhotoAssembler: NSObject {

    @IBOutlet weak var view: RegistrationTakePhotoViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = RegistrationTakePhotoInteractor()
        let presenter = RegistrationTakePhotoPresenter()
        let router = RegistrationTakePhotoRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
