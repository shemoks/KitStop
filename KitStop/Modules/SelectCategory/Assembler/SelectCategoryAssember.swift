//
//  SelectCategoryAssember.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - SelectCategoryAssembler

final class SelectCategoryAssembler: NSObject {

    @IBOutlet weak var view: SelectCategoryViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = SelectCategoryInteractor()
        let presenter = SelectCategoryPresenter()
        let router = SelectCategoryRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
