//
//  Event.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

public class Event: NSObject, Decodable {
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

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        saleEnabled = try container.decodeIfPresent(Bool.self, forKey: .saleEnabled) ?? false
        rsvpTotal = try container.decodeIfPresent(Int.self, forKey: .rsvpTotal) ?? 0
        eventDescription = try container.decodeIfPresent(String.self, forKey: .eventDescription) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        link = try container.decodeIfPresent(String.self, forKey: .link) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        poster = try container.decodeIfPresent(String.self, forKey: .poster) ?? ""
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        rsvp = try container.decodeIfPresent([User].self, forKey: .rsvp) ?? []
        date = try container.decodeIfPresent([EventDate].self, forKey: .date) ?? []
        venue = try container.decodeIfPresent(Venue.self, forKey: .venue)
    }
}
