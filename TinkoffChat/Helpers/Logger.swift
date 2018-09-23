//
//  Logger.swift
//  TinkoffChat
//
//  Created by st.i on 22.09.2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class Logger: NSObject {

    static func logAppState(_ previousState: UIApplicationState, _ methodName: String) {
        var previousStateName: String = ""
        var currentStateName: String = ""
        
//        if let unwrappedPreviousState = previousState {
            switch previousState {
            case .active:
                previousStateName = "ACTIVE" //"Active"
            case .inactive:
                previousStateName = "INACTIVE" //"Inactive"
            case .background:
                previousStateName = "BACKGROUND" //"Background"
            }
//        }else{
//            previousStateName = 
//        }
        
        switch UIApplication.shared.applicationState {
        case .active:
            currentStateName = "ACTIVE" //"Active"
        case .inactive:
            currentStateName = "INACTIVE" //"Inactive"
        case .background:
            currentStateName = "BACKGROUND" //"Background"
        }
        
        let stringToLog = "Application moved from \(previousStateName) state to \(currentStateName) state: \(methodName)"
        
        print(stringToLog)
    }
    
    static func logViewControllerMethod(_ methodName: String) {
        print(methodName)
    }
}
