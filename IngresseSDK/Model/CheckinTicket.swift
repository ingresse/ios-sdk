//
//  CheckinTicket.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/25/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class CheckinTicket: Codable {
    public var code: String = ""
    public var status: Int = -1
    public var checked: Int = -1
    public var lastUpdate: Int = 0

    public var lastCheckin: LastCheckin?
    public var owner: User?

    enum CodingKeys: String, CodingKey {
        case code
        case status
        case checked
        case lastUpdate
        case lastCheckin
        case owner
    }
}


public class LastCheckin: Codable {
    public var timestamp: Int = 0
    public var holder: User?
    public var operatorUser: User?

    enum CodingKeys: String, CodingKey {
        case operatorUser = "operator"
        case timestamp
        case holder
    }
}

