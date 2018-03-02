//
//  WalletItem.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 7/19/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class WalletItem: Codable {
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
}
