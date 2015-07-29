//
//  DateHelper.swift
//  Rain Shield
//
//  Created by Kreft, Michal on 29.07.15.
//  Copyright © 2015 kreftmichal. All rights reserved.
//

import Foundation

class DateHelper: NSObject {
    
    class func endOfDay() -> NSTimeInterval {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: NSDate())
        components.hour = 23
        components.minute = 59
        components.second = 59
        return calendar.dateFromComponents(components)!.timeIntervalSince1970
    }
    
}
