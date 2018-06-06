//
//  UserData.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 7/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class UserData: Codable {
    public var name: String
    public var lastname: String
    public var email: String
    public var state: String
    public var city: String
    public var district: String
    public var street: String
    public var zip: String
    public var complement: String
    public var phone: String
    public var number: String
    public var fbUserId: String
    public var verified: Bool

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        lastname = try container.decodeIfPresent(String.self, forKey: .lastname) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        state = try container.decodeIfPresent(String.self, forKey: .state) ?? ""
        city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        district = try container.decodeIfPresent(String.self, forKey: .district) ?? ""
        street = try container.decodeIfPresent(String.self, forKey: .street) ?? ""
        zip = try container.decodeIfPresent(String.self, forKey: .zip) ?? "000000"
        complement = try container.decodeIfPresent(String.self, forKey: .complement) ?? ""
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        number = try container.decodeIfPresent(String.self, forKey: .number) ?? ""
        fbUserId = try container.decodeIfPresent(String.self, forKey: .fbUserId) ?? ""
        verified = try container.decodeIfPresent(Bool.self, forKey: .verified) ?? false
    }
}
