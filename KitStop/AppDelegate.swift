//
//  AppDelegate.swift
//  KitStop
//
//  Created by Vitalii Krayovyi on 12/7/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -80.0), for: .default)
        IQKeyboardManager.sharedManager().enable = true
        return true
    }


}

