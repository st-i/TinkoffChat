//
//  AppDelegate.swift
//  TinkoffChat
//
//  Created by st.i on 21.09.2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var previousAppState: UIApplicationState?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool { //+
        // Override point for customization after application launch.
        Logger.logAppState(previousAppState ?? UIApplicationState.inactive, #function)
        previousAppState = UIApplication.shared.applicationState
//        let state = UIApplication.shared.applicationState
//        print("\(UIApplication.shared.applicationState.rawValue), \(#function)")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { //+
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        Logger.logAppState(previousAppState ?? UIApplicationState.inactive, #function)
        previousAppState = UIApplication.shared.applicationState
//        _ = UIApplication.shared.applicationState
//        print("\(UIApplication.shared.applicationState.rawValue), \(#function)")
    }

    func applicationDidEnterBackground(_ application: UIApplication) { //+
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Logger.logAppState(previousAppState ?? UIApplicationState.inactive, #function)
        previousAppState = UIApplication.shared.applicationState
//        _ = UIApplication.shared.applicationState
//        print("\(UIApplication.shared.applicationState.rawValue), \(#function)")
    }

    func applicationWillEnterForeground(_ application: UIApplication) { //+
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        Logger.logAppState(previousAppState ?? UIApplicationState.inactive, #function)
        previousAppState = UIApplication.shared.applicationState
//        _ = UIApplication.shared.applicationState
//        print("\(UIApplication.shared.applicationState.rawValue), \(#function)")
    }

    func applicationDidBecomeActive(_ application: UIApplication) { //+
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        Logger.logAppState(previousAppState ?? UIApplicationState.inactive, #function)
        previousAppState = UIApplication.shared.applicationState
//        _ = UIApplication.shared.applicationState
//        print("\(UIApplication.shared.applicationState.rawValue), \(#function)")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        Logger.logAppState(previousAppState ?? UIApplicationState.inactive, #function)
        previousAppState = UIApplication.shared.applicationState
//        _ = UIApplication.shared.applicationState
//        print("\(UIApplication.shared.applicationState.rawValue), \(#function)")
    }


}

