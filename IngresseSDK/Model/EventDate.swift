//
//  EventDate.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 12/5/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class EventDate: NSObject, Codable {
    public var id: Int = 0
    public var date: String = ""
    public var time: String = ""
    public var status: String = ""
    public var dateTime: DateTime?

    public class DateTime: NSObject, Codable {
        public var date: String = ""
        public var time: String = ""
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
        time = try container.decodeIfPresent(String.self, forKey: .time) ?? ""
        dateTime = try container.decodeIfPresent(DateTime.self, forKey: .dateTime)
    }
}
