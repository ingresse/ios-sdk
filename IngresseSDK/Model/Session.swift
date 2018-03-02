//
//  Session.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2016 Ingresse. All rights reserved.
//

public class Session: Codable {
    public var id: Int = 0
    public var date: String = ""
    public var timestamp: String = ""
    public var datetime: DateTime?

    public class DateTime: Codable {
        var timestamp = ""

        var date: String {
            return timestamp.toDate().toString(format: .dateHourAt)
        }
        var dateTime: Date {
            return timestamp.toDate()
        }
    }
}
