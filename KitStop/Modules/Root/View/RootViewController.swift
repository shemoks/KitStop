//
//  RootViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 09/12/2016.
//  Copyright © 2016 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - RootViewController

final class RootViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: RootViewOutput!

    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        presenter.handleViewDidload()
    }

}
// MARK: - RootViewInput

extension RootViewController: RootViewInput {

}
