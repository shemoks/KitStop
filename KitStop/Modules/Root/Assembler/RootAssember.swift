//
//  RootAssember.swift
//  KitStop
//
//  Created by Shemshur Oksana on 09/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Foundation
import UIKit

// MARK: - RootAssembler

final class RootAssembler: NSObject {

    @IBOutlet weak var view: RootViewController!

    override func awakeFromNib() {
        super.awakeFromNib()

        let interactor = RootInteractor()
        let presenter = RootPresenter()
        let router = RootRouter()

        view.presenter = presenter
        view.moduleInput = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.flowController = view
    }
    

}
