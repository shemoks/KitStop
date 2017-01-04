//
//  UserInformationAssember.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - UserInformationAssembler

final class UserInformationAssembler: NSObject {

    @IBOutlet weak var view: UserInformationViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = UserInformationInteractor()
        let presenter = UserInformationPresenter()
        let router = UserInformationRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
