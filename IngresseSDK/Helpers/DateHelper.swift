//
//  DateHelper.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2016 Gondek. All rights reserved.
//

import Foundation

enum DateFormat: String {
    case timestamp = "yyyy-MM-dd'T'HH:mm:ssZ"
    case gmtTimestamp = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    case dateHourSpace = "dd/MM/yyyy HH:mm"
    case dateHourAt = "dd/MM/yyyy 'às' HH:mm"
}

extension Date {
    
    /// Transform into string based on format
    ///
    /// - Parameter format: String format of desired output (default is "dd/MM/yyyy HH:mm")
    /// - Returns: Date converted to string
    func toString(format: DateFormat = .dateHourSpace) -> String {
        let df = DateFormatter()
        df.dateFormat = format.rawValue
        df.timeZone = TimeZone(abbreviation: "GMT")
        df.locale = Locale(identifier: "en_US_POSIX")
        
        return df.string(from: self)
    }
    
    /// Get week day string with 3 characters
    func weekDay() -> String {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let comp = (calendar as NSCalendar).components(.weekday, from: self)
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

extension String {
    
    /// Convert string to Date
    ///
    /// - Parameter format: Current string format (default is "yyyy-MM-dd'T'HH:mm:ssZ")
    /// - Returns: Date converted from string (Current date returned in case of error)
    func toDate(format: DateFormat = .timestamp) -> Date {
        let df = DateFormatter()
        df.dateFormat = format.rawValue
        let posix = Locale(identifier: "en_US_POSIX")
        df.locale = posix
        
        return df.date(from: self) ?? Date()
    }
}
