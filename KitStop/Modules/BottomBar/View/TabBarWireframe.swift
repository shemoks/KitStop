//
//  TabBarWireframe.swift
//  KitStop
//
//  Created by Dmitriy Melnichenko on 2/3/17.
//  Copyright © 2017 MOZI Development. All rights reserved.
//

import Foundation
import UIKit

class TabBarWireframe: NSObject {
    
    let wireFrames: [TabBarInterface]
    var rootWireframe: MainAssembler?
    
    init(_ wireFrames: TabBarInterface) {
        self.wireFrames = [wireFrames]
        super.init()
    }
    
    private override init() {
        self.wireFrames = [TabBarInterface]()
    }
    
    func installIntoWindow(window: UIWindow) {
        let tabBarController = MainTabBarController()
        
        var viewControllers = [UIViewController]()
        
        for wireFrame in wireFrames {
            viewControllers.append(wireFrame.configuredViewController())
        }
        
        tabBarController.viewControllers = viewControllers
        tabBarController.navigationItem.title = "Title"

        self.rootWireframe?.installTabBarControllerIntoWindow(tabBarController: tabBarController, window: window)
    }
    
}
