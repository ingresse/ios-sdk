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
            if statusChange.status == "pending" { return statusChange.date }
        }

        return ""
    }
    public var accepted: String {
        for statusChange in history {
            if statusChange.status == "accepted" { return statusChange.date }
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
        public var date: String = ""
    }
}
