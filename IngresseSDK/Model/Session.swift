//
//  Session.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2016 Ingresse. All rights reserved.
//

public class Session: NSObject, Codable {
    public var id: Int
    public var date: String
    public var timestamp: String
    public var datetime: DateTime?

    public class DateTime: NSObject, Codable {
        var timestamp = ""

        var date: String {
            return timestamp.toDate().toString(format: .dateHourAt)
        }
        var dateTime: Date {
            return timestamp.toDate()
        }
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
        timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp) ?? ""
        datetime = try container.decodeIfPresent(DateTime.self, forKey: .datetime)
    }
}
