//
//  BottomBarAssember.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - BottomBarAssembler

final class BottomBarAssembler: NSObject {

    @IBOutlet weak var view: BottomBarViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = BottomBarInteractor()
        let presenter = BottomBarPresenter()
        let router = BottomBarRouter()

        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
    }

}
