//
//  Refund.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Refund: Codable {
    public var operatorId: String = ""
    public var reason: String = ""
    public var date: String = ""

    enum CodingKeys: String, CodingKey {
        case operatorId = "operator"
        case reason
        case date
    }
}
