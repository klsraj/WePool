//
//  UIDate.swift
//  WePool
//
//  Created by Raj Kadiyala on 5/2/19.
//  Copyright © 2019 WePool. All rights reserved.
//

import Foundation

extension Date {
    
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
}
