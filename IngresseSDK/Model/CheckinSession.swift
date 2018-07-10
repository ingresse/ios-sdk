//
//  CheckinSession.swift
//  IngresseSDK
//
//  Created by Mobile Developer on 7/6/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class CheckinSession: NSObject, Decodable {
    public var session: Session?
    public var owner: User?
    public var lastStatus: CheckinStatus?

    enum CodingKeys: String, CodingKey{
        case session
        case owner
        case lastStatus
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        session = try container.decodeIfPresent(Session.self, forKey: .session)
        owner = try container.decodeIfPresent(User.self, forKey: .owner)
        lastStatus = try container.decodeIfPresent(CheckinStatus.self, forKey: .lastStatus)
    }
}
