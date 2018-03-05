//
//  Ticket.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2016 Gondek. All rights reserved.
//

public class UserTicket: NSObject, Codable {
    public var id: Int = 0
    public var holderId: Int = 0
    public var guestTypeId: Int = 0
    public var ticketTypeId: Int = 0
    public var transactionId: String = ""
    
    public var code: String = ""
    public var itemType: String = ""
    public var sequence: String = "00000"
    public var guestName: String?
    public var title: String = ""
    public var type: String = ""
    public var desc: String = ""
    public var checked: Bool = false
    
    public var sessions: [Session] = []
    
    public var eventId: Int = 0
    public var eventTitle: String = ""
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
}

