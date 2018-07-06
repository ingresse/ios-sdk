//
//  Planner.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 12/5/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Planner: NSObject, Codable {
    public var id: Int = 0
    public var name: String = ""
    public var username: String = ""
    public var email: String = ""
    public var phone: String = ""
    public var link: String = ""
    public var logo: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case phone
        case link
        case logo
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        username = try container.decodeIfPresent(String.self, forKey: .username) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        link = try container.decodeIfPresent(String.self, forKey: .link) ?? ""
        logo = try container.decodeIfPresent(String.self, forKey: .logo) ?? ""
    }
}
