//
//  Tools.swift
//  YAWA
//
//  Created by Viajeros Lado B on 24/06/2019.
//  Copyright © 2019 DragonShine. All rights reserved.
//

import Foundation

struct Tools {
    private init() { }
    
    enum TimeFormat: String {
        case hourMinutes = "HH:mm"
        case dayMonthHourMinutes = "dd MMM HH:mm"
        case fullDescription = "EEEE d MMM yyyy HH:mm"
    }
    
    static func unixTimestampToString(unixNumber: Int, secondsFromGMT: Int, format: TimeFormat) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixNumber))

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format.rawValue
        dateFormatterPrint.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        
        return(dateFormatterPrint.string(from: date))
    }
}
