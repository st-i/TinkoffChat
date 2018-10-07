//
//  DatesHelper.swift
//  TinkoffChat
//
//  Created by st.i on 07/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

class DatesHelper: NSObject {
    
    static func dateOfCurrentDayBeginning() -> Date {
        let currentCalendar = NSCalendar.current
        let hour = 0
        let minute = 0
        let second = 0
        var components = currentCalendar.dateComponents([.day, .month, .year], from: Date())
        components.hour = hour
        components.minute = minute
        components.second = second
        return currentCalendar.date(from: components)!
    }
}
