//
//  WalletItem.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 7/19/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class WalletItem: NSObject, Codable {
    public var id: Int = -1
    public var ownerId: Int = -1
    public var title: String = ""
    public var link: String = ""
    public var type: String = ""
    public var poster: String = ""
    public var eventDescription: String = ""
    public var tickets: Int = 0
    public var transfered: Int = 0
    public var sessions: [Session] = []
    public var sessionList: [Session] = []
    public var customTickets: [CustomTicket] = []
    public var venue: Venue?

    enum CodingKeys: String, CodingKey {
        case id
        case ownerId
        case title
        case link
        case type
        case poster
        case eventDescription = "description"
        case tickets
        case transfered
        case sessions
        case sessionList
        case customTickets
        case venue
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        link = try container.decodeIfPresent(String.self, forKey: .link) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        ownerId = try container.decodeIfPresent(Int.self, forKey: .ownerId) ?? -1
        tickets = try container.decodeIfPresent(Int.self, forKey: .tickets) ?? 0
        poster = try container.decodeIfPresent(String.self, forKey: .poster) ?? ""
        transfered = try container.decodeIfPresent(Int.self, forKey: .transfered) ?? 0
        sessions = try container.decodeIfPresent([Session].self, forKey: .sessions) ?? []
        sessionList = try container.decodeIfPresent([Session].self, forKey: .sessionList) ?? []
        eventDescription = try container.decodeIfPresent(String.self, forKey: .eventDescription) ?? ""
        customTickets = try container.decodeIfPresent([CustomTicket].self, forKey: .customTickets) ?? []

        venue = try container.decodeIfPresent(Venue.self, forKey: .venue)
    }
}
