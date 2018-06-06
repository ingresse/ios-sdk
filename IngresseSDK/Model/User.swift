//
//  User.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class User: NSObject, Decodable {
    public var id: Int = 0
    public var name: String = ""
    public var email: String = ""
    public var type: String = ""
    public var username: String = ""
    public var phone: String = ""
    public var cellphone: String = ""
    public var picture: String = ""
    public var social: [SocialAccount] = []

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case type
        case username
        case phone
        case cellphone
        case picture
        case social
    }

    public override init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        username = try container.decodeIfPresent(String.self, forKey: .username) ?? ""
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        cellphone = try container.decodeIfPresent(String.self, forKey: .cellphone) ?? ""
        picture = try container.decodeIfPresent(String.self, forKey: .picture) ?? ""
        social = try container.decodeIfPresent([SocialAccount].self, forKey: .social) ?? []
    }
}
