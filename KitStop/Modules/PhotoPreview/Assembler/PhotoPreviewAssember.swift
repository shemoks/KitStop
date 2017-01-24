//
//  PhotoPreviewAssember.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 24/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation

// MARK: - PhotoPreviewAssembler

final class PhotoPreviewAssembler: NSObject {

    @IBOutlet weak var view: PhotoPreviewViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = PhotoPreviewInteractor()
        let presenter = PhotoPreviewPresenter()
        let router = PhotoPreviewRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
