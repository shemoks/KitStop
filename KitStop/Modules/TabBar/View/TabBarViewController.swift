//
//  TabBarViewController.swift
//  KitStop
//
//  Created by Shemshur Oksana on 14/02/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile
import UIKit

// MARK: - TabBarViewController

final class TabBarViewController: UITabBarController, FlowController {

    // MARK: - VIPER stack

    var presenter: TabBarViewOutput!
    var freshLaunch = true
    
    override func viewWillAppear(_ animated: Bool) {
        if freshLaunch {
            freshLaunch = false
            _ = self.selectedIndex = 2
        }
    }

}

// MARK: - TabBarViewInput

extension TabBarViewController: TabBarViewInput {

}
