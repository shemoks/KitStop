//
//  SelectImageAssember.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 04/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - SelectImageAssembler

final class SelectImageAssembler: NSObject {

    @IBOutlet weak var view: SelectImageViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = SelectImageInteractor()
        let presenter = SelectImagePresenter()
        let router = SelectImageRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
