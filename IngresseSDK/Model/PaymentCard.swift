//
//  PaymentCard.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 12/4/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class PaymentCard: NSObject, Codable {
    public var firstDigits: String
    public var lastDigits: String

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstDigits = try container.decodeIfPresent(String.self, forKey: .firstDigits) ?? ""
        lastDigits = try container.decodeIfPresent(String.self, forKey: .lastDigits) ?? ""
    }
}
