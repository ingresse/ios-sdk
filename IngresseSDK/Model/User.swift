//
//  User.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class User: NSObject, Codable {
    public var id: Int = 0
    public var name: String = ""
    public var email: String = ""
    public var username: String = ""
    public var phone: String = ""
    public var cellphone: String = ""
    public var picture: String = ""

    enum CodingKeys: String, CodingKey {
        case id = "userId"
        case name
        case email
        case username
        case phone
        case cellphone
        case picture
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        username = try container.decodeIfPresent(String.self, forKey: .username) ?? ""
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        cellphone = try container.decodeIfPresent(String.self, forKey: .cellphone) ?? ""
        picture = try container.decodeIfPresent(String.self, forKey: .picture) ?? ""
    }
}
