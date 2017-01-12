//
//  BottomBarViewController.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 05/01/2017.
//  Copyright © 2017 MoziDev. All rights reserved.
//

import Chamomile

// MARK: - BottomBarViewController

final class BottomBarViewController: UIView, UITabBarDelegate {

    // MARK: - VIPER stack

    var presenter: BottomBarViewOutput!
    
    var tappedItem: BottomBarTransitionProtocol?
    
    @IBOutlet weak var tabBar: UITabBar!
    
    override func awakeFromNib() {
        self.tabBar.delegate = self
//        print("\(presenter)--------------------------------------------------")
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        for (index, element) in (tabBar.items?.enumerated())! {
            if element.isEqual(item) {
                tappedItem?.openModule(identifier: index)
            }
        }
    }
    
}

// MARK: - BottomBarViewInput

extension BottomBarViewController: BottomBarViewInput {

}
