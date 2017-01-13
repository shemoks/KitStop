//
//  CustomListAssember.swift
//  KitStop
//
//  Created by Shemshur Oksana on 12/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - CustomListAssembler

final class CustomListAssembler: NSObject {

    @IBOutlet weak var view: CustomListViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = CustomListInteractor()
        let presenter = CustomListPresenter()
        let router = CustomListRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
