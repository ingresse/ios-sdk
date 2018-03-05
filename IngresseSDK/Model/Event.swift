//
//  Event.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

public class Event: NSObject, Codable {
    public var id: Int = 0
    public var title: String = ""
    public var link: String = ""
    public var type: String = ""
    public var poster: String = ""
    public var status: String = ""
    public var rsvpTotal: Int = 0
    public var saleEnabled: Bool = false
    public var eventDescription: String = ""
    public var rsvp: [User] = []
    public var date: [EventDate] = []
    public var venue: Venue?

    enum CodingKeys: String, CodingKey {
        case eventDescription = "description"
        case id
        case title
        case link
        case type
        case poster
        case status
        case rsvpTotal
        case saleEnabled
        case rsvp
        case date
        case venue
    }
}
