//
//  DateHelper.swift
//  TicketsShare-Prototype
//
//  Created by Rubens Gondek on 5/11/16.
//  Copyright © 2016 Gondek. All rights reserved.
//

import Foundation

class DateHelper {
    
    static let df = DateFormatter()

    // Convert String
    static func dateFromString(_ str: String) -> Date {
        df.dateFormat = "dd/MM/yyyy HH:mm"
        return df.date(from: str) ?? Date()
    }
    
    static func stringFromTimeStamp(_ str: String) -> String {
        return stringFromDate(dateFromTimeStamp(str))
    }
    
    static func dateFromTimeStamp(_ str: String) -> Date {
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let posix = Locale(identifier: "en_US_POSIX")
        df.locale = posix
        return df.date(from: str)!
    }
    
    static func timeStampFromDate(_ date: Date) -> String {
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let posix = Locale(identifier: "en_US_POSIX")
        df.locale = posix
        return df.string(from: date)
    }
    
    // Convert Date to format
    static func stringFromDate(_ date: Date) -> String {
        df.dateFormat = "dd/MM/yyyy 'às' HH:mm"
        return df.string(from: date)
    }
    
    static func stringFromTimestamp(_ timestamp: String) -> String {
        let date = dateFromString(timestamp)
        return stringFromDate(date)
    }
    
    // Get Week day with 3 characters
    static func getWeekDay(_ date: Date) -> String {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let comp = (calendar as NSCalendar).components(.weekday, from: date)
        let day = comp.weekday
        switch day! {
        case 0:
            return "DOM"
        case 1:
            return "SEG"
        case 2:
            return "TER"
        case 3:
            return "QUA"
        case 4:
            return "QUI"
        case 5:
            return "SEX"
        case 6:
            return "SAB"
        default:
            return "---"
        }
    }
}
