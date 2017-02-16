//
//  TabBarViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 14/02/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - TabBarViewController

final class TabBarViewController: UIViewController, FlowController {

    // MARK: - VIPER stack

    var presenter: TabBarViewOutput!

}

// MARK: - TabBarViewInput

extension TabBarViewController: TabBarViewInput {

}
