//
//  Transfer.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2016 Ingresse. All rights reserved.
//

public class Transfer: NSObject, Codable {
    public var transferId: Int = 0
    public var userId: Int = 0
    public var status: String = ""
    public var email: String = ""
    public var name: String = ""
    public var type: String = ""
    public var picture: String = ""
    public var socialId: [SocialAccount] = []
    public var history: [StatusChange] = []

    public var created: String {
        for statusChange in history {
            if statusChange.status == "pending" { return statusChange.creationDate }
        }

        return ""
    }
    public var accepted: String {
        for statusChange in history {
            if statusChange.status == "accepted" { return statusChange.creationDate }
        }

        return ""
    }
    
    public var socialIdDict: [String:String] {
        get {
            var dict = [String:String]()
            for account in socialId {
                dict[account.network] = String(account.id)
            }
            
            return dict
        }
    }

    public class StatusChange: NSObject, Codable {
        public var status: String = ""
        public var creationDate: String = ""
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        userId = try container.decodeIfPresent(Int.self, forKey: .userId) ?? 0
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        picture = try container.decodeIfPresent(String.self, forKey: .picture) ?? ""
        transferId = try container.decodeIfPresent(Int.self, forKey: .transferId) ?? 0
        history = try container.decodeIfPresent([StatusChange].self, forKey: .history) ?? []
        socialId = try container.decodeIfPresent([SocialAccount].self, forKey: .socialId) ?? []
    }
}
