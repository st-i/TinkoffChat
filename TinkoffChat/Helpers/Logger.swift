//
//  Logger.swift
//  TinkoffChat
//
//  Created by st.i on 22.09.2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

#if WITHLOG
let LOG_TOGGLE = true
#else
let LOG_TOGGLE = false
#endif

public enum ApplicationState: Int {
    case active
    case inactive
    case background
    case notRunning
}

class Logger: NSObject {
    
    static func logAppState(_ previousState: ApplicationState, _ methodName: String) {
        if LOG_TOGGLE {
            var previousStateName: String = ""
            var currentStateName: String = ""
            
            switch previousState {
            case .active:
                previousStateName = "ACTIVE"
            case .inactive:
                previousStateName = "INACTIVE"
            case .background:
                previousStateName = "BACKGROUND"
            case .notRunning:
                previousStateName = "NOT RUNNING"
            }
            
            switch UIApplication.shared.applicationState {
            case .active:
                currentStateName = "ACTIVE"
            case .inactive:
                currentStateName = "INACTIVE"
            case .background:
                currentStateName = "BACKGROUND"
            }
            
            let stringToLog = "Application moved from \(previousStateName) state to \(currentStateName) state: \(methodName)"
            print(stringToLog)
        }
    }
    
    static func logViewControllerMethod(_ methodName: String) {
        if LOG_TOGGLE {
            let stringToLog = "View Controller's called method is \(methodName)"
            print(stringToLog)
        }
    }
    
    static func logAppThemeColor(_ selectedColor: UIColor) {
        print("Selected color is \(selectedColor)")
    }
}
