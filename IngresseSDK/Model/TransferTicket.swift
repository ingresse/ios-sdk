//
//  TransferTicket.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransferTicket: NSObject, Codable {
    public var id: Int = 0
    public var guestTypeId: Int = 0
    public var ticketTypeId: Int = 0
    public var name: String = ""
    public var type: String = ""
    public var desc: String = ""

    enum CodingKeys: String, CodingKey {
        case desc = "description"
        case id
        case guestTypeId
        case ticketTypeId
        case name
        case type
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        guestTypeId = try container.decodeIfPresent(Int.self, forKey: .guestTypeId) ?? 0
        ticketTypeId = try container.decodeIfPresent(Int.self, forKey: .ticketTypeId) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        desc = try container.decodeIfPresent(String.self, forKey: .desc) ?? ""
    }
}
