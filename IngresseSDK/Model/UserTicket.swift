//
//  Ticket.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2016 Gondek. All rights reserved.
//

public class UserTicket: NSObject, Codable {
    public var id: Int
    public var holderId: Int
    public var guestTypeId: Int
    public var ticketTypeId: Int
    public var transactionId: String
    
    public var code: String
    public var itemType: String
    public var sequence: String
    public var guestName: String?
    public var title: String
    public var type: String
    public var desc: String
    public var checked: Bool
    
    public var sessions: [Session]
    
    public var eventId: Int
    public var eventTitle: String
    public var eventVenue: Venue?
    
    public var receivedFrom: Transfer?
    public var transferedTo: Transfer?
    
    public var currentHolder: Transfer?

    enum CodingKeys: String, CodingKey {
        case id
        case holderId
        case guestTypeId
        case ticketTypeId
        case transactionId
        case code
        case itemType
        case sequence
        case guestName
        case title
        case type
        case desc = "description"
        case checked
        case sessions
        case eventId
        case eventTitle
        case eventVenue
        case receivedFrom
        case transferedTo
        case currentHolder
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        holderId = try container.decodeIfPresent(Int.self, forKey: .holderId) ?? 0
        guestTypeId = try container.decodeIfPresent(Int.self, forKey: .guestTypeId) ?? 0
        ticketTypeId = try container.decodeIfPresent(Int.self, forKey: .ticketTypeId) ?? 0
        transactionId = try container.decodeIfPresent(String.self, forKey: .transactionId) ?? ""
        code = try container.decodeIfPresent(String.self, forKey: .code) ?? ""
        itemType = try container.decodeIfPresent(String.self, forKey: .itemType) ?? ""
        sequence = try container.decodeIfPresent(String.self, forKey: .sequence) ?? "000000"
        guestName = try container.decodeIfPresent(String.self, forKey: .guestName)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        desc = try container.decodeIfPresent(String.self, forKey: .desc) ?? ""
        checked = try container.decodeIfPresent(Bool.self, forKey: .checked) ?? false
        sessions = try container.decodeIfPresent([Session].self, forKey: .sessions) ?? []
        eventId = try container.decodeIfPresent(Int.self, forKey: .eventId) ?? 0
        eventTitle = try container.decodeIfPresent(String.self, forKey: .eventTitle) ?? ""
        eventVenue = try container.decodeIfPresent(Venue.self, forKey: .eventVenue)
        receivedFrom = try container.decodeIfPresent(Transfer.self, forKey: .receivedFrom)
        transferedTo = try container.decodeIfPresent(Transfer.self, forKey: .transferedTo)
        currentHolder = try container.decodeIfPresent(Transfer.self, forKey: .currentHolder)
    }
}

