//
//  SignUpEmailAssember.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 15/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Foundation

// MARK: - SignUpEmailAssembler

final class SignUpEmailAssembler: NSObject {

    @IBOutlet weak var view: SignUpEmailViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = SignUpEmailInteractor()
        let presenter = SignUpEmailPresenter()
        let router = SignUpEmailRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
