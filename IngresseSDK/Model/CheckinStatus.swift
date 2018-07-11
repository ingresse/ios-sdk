//
//  CheckinStatus.swift
//  IngresseSDK
//
//  Created by Mobile Developer on 7/6/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class CheckinStatus: NSObject, Decodable {
    public var id: Int
    public var timestamp: Int
    public var operation: String
    public var operatorUser: User?
    public var holder: User?

    enum CodingKeys: String, CodingKey {
        case id
        case timestamp
        case operation
        case operatorUser = "operator"
        case holder
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        timestamp = try container.decodeIfPresent(Int.self, forKey: .timestamp) ?? -1
        operation = try container.decodeIfPresent(String.self, forKey: .operation) ?? ""
        operatorUser = try container.decodeIfPresent(Operator.self, forKey: .operatorUser)
        holder = try container.decodeIfPresent(Owner.self, forKey: .holder)
    }
}
