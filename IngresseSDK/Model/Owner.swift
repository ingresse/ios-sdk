//
//  Owner.swift
//  IngresseSDK
//
//  Created by Mobile Developer on 7/10/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class Owner: NSObject, Decodable{
    public var id: Int = 0
    public var email: String = ""
    public var username: String = ""
    public var name: String = ""
    public var phone: String = ""
    public var picture: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case username
        case name
        case phone
        case picture
    }

    public required init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        username = try container.decodeIfPresent(String.self, forKey: .username) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        picture = try container.decodeIfPresent(String.self, forKey: .picture) ?? ""
    }
}
