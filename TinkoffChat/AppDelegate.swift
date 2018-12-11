//
//  AppDelegate.swift
//  TinkoffChat
//
//  Created by st.i on 21.09.2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

//BUNDLE_PRODUCT_IDENTIFIER

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var previousAppState: ApplicationState = .notRunning

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        logAppState(#function)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        logAppState(#function)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        logAppState(#function)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        logAppState(#function)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        logAppState(#function)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        logAppState(#function)
    }
    
    //MARK: Helpers
    
    private func logAppState(_ methodName: String) {
        Logger.logAppState(previousAppState, methodName)
        if methodName == "applicationWillTerminate" {
            previousAppState = .notRunning
        }else{
            previousAppState = ApplicationState(rawValue: UIApplication.shared.applicationState.rawValue)!
        }
    }
}
