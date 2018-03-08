//
//  CustomTicket.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 10/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class CustomTicket: NSObject, Codable {
    public var name: String = ""
    public var slug: String = ""

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        slug = try container.decodeIfPresent(String.self, forKey: .slug) ?? ""
    }
}
