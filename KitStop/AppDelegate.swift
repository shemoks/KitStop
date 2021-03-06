//
//  AppDelegate.swift
//  KitStop
//
//  Created by Vitalii Krayovyi on 12/7/16.
//  Copyright © 2016 MOZI Development. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import IQKeyboardManagerSwift
import RealmSwift
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -80.0), for: .default)
        IQKeyboardManager.sharedManager().enable = true
        UINavigationBar.appearance().tintColor = UIColor().hexStringToUIColor(hex: "ff8830")
        UITabBar.appearance().tintColor = UIColor(colorLiteralRed: 255/255.0, green: 136/255.0, blue: 40/255.0, alpha: 1.0)

        Fabric.with([Crashlytics.self])
        
        // Override point for customization after application launch.
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(
            application,
            open: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
    }
    
}

