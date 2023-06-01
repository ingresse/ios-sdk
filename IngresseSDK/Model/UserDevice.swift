//
//  UserDevice.swift
//  IngresseSDK
//
//  Created by Phillipi Unger Lino on 01/06/23.
//  Copyright © 2023 Ingresse. All rights reserved.
//

public class UserDevice: Codable {
    public let uuid: String?
    public let id: String?
    public let name: String?
    public let createdAt: String?
    public let active: Bool?
    public let validated: Bool?

    enum CodingKeys: String, CodingKey {
        case uuid
        case id
        case name
        case createdAt = "created_at"
        case active
        case validated
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try? container.decodeIfPresent(String.self, forKey: .uuid) ?? ""
        id = try? container.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try? container.decodeIfPresent(String.self, forKey: .name) ?? ""
        createdAt = try? container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        active = try? container.decodeIfPresent(Bool.self, forKey: .active) ?? false
        validated = try? container.decodeIfPresent(Bool.self, forKey: .validated) ?? false
    }
}

