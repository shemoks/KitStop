//
//  SignUpAssember.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 08/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Foundation

// MARK: - SignUpAssembler

final class SignUpAssembler: NSObject {

    @IBOutlet weak var view: SignUpViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter()
        let router = SignUpRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
