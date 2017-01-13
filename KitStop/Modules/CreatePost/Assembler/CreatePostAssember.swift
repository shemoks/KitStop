//
//  CreatePostAssember.swift
//  KitStop
//
//  Created by Shemshur Oksana on 03/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - CreatePostAssembler

final class CreatePostAssembler: NSObject {

    @IBOutlet weak var view: CreatePostViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = CreatePostInteractor()
        let presenter = CreatePostPresenter()
        let router = CreatePostRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
