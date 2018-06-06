//
//  Refund.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Refund: NSObject, Codable {
    public var operatorId: String = ""
    public var reason: String = ""
    public var date: String = ""

    enum CodingKeys: String, CodingKey {
        case operatorId = "operator"
        case reason
        case date
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
        reason = try container.decodeIfPresent(String.self, forKey: .reason) ?? ""
        operatorId = try container.decodeIfPresent(String.self, forKey: .operatorId) ?? ""
    }
}
