//
//  KitFolioDetailedAssember.swift
//  KitStop
//
//  Created by Sasha Atamanskiy on 16/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Foundation
import UIKit

// MARK: - KitFolioDetailedAssembler

final class KitFolioDetailedAssembler: NSObject {

    @IBOutlet weak var postDescription: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var view: KitFolioDetailedViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = KitFolioDetailedInteractor()
        let presenter = KitFolioDetailedPresenter()
        let router = KitFolioDetailedRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }

}
