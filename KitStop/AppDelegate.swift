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
        IQKeyboardManager.sharedManager().enable = true
        return true
    }
}

