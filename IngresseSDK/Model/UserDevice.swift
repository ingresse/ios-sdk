//
//  UserDevice.swift
//  IngresseSDK
//
//  Created by Phillipi Unger Lino on 01/06/23.
//  Copyright © 2023 Ingresse. All rights reserved.
//

public class UserDevice: Codable {
    public let id: String?
    public let name: String?
    public let deviceType: String?
    public let verified: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case deviceType = "device_type"
        case verified
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try? container.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try? container.decodeIfPresent(String.self, forKey: .name) ?? ""
        deviceType = try? container.decodeIfPresent(String.self, forKey: .deviceType) ?? ""
        verified = try? container.decodeIfPresent(Bool.self, forKey: .verified) ?? false
    }
}

