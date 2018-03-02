//
//  EventDate.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 12/5/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class EventDate: Codable {
    public var id: Int = 0
    public var date: String = ""
    public var time: String = ""
    public var status: String = ""
    public var dateTime: DateTime?

    public class DateTime: Codable {
        public var date: String = ""
        public var time: String = ""
    }
}
