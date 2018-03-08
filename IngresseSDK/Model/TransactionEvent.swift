//
//  TransactionEvent.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionEvent: NSObject, Codable {
    public var id: String = ""

    public var title: String = ""
    public var type: String = ""
    public var status: String = ""
    public var link: String = ""
    public var poster: String = ""

    public var venue: Venue?

    public var saleEnabled: Bool = false
    public var taxToCostumer: Int = 0

    public class Venue: NSObject, Codable {
        public var name: String = ""
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        link = try container.decodeIfPresent(String.self, forKey: .link) ?? ""
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        poster = try container.decodeIfPresent(String.self, forKey: .poster) ?? ""
        taxToCostumer = try container.decodeIfPresent(Int.self, forKey: .taxToCostumer) ?? 0
        saleEnabled = try container.decodeIfPresent(Bool.self, forKey: .saleEnabled) ?? false

        venue = try container.decodeIfPresent(Venue.self, forKey: .venue)
    }
}
