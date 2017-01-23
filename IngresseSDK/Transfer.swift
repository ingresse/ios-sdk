//
//  Transfer.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2016 Ingresse. All rights reserved.
//

import Foundation

public class Transfer {
    public var id         : String
    public var status     : String
    public var userId     : String
    public var userEmail  : String
    public var userName   : String
    public var picture    : String
    public var created    : String?
    public var accepted   : String?
    public var socialId   : [String: String]
    
    init(withJSON json: [String:Any]) {
        let id = String(json["transferId"] as! Int)
        
        self.id = id
        self.status = json["status"] as! String
        self.picture = json["picture"] as! String
        self.userId = String(json["userId"] as! Int)
        self.userEmail = json["email"] as! String
        self.userName = json["name"] as! String
        
        var socialId = [String:String]()
        let arrSocial = json["socialId"] as! [[String:String]]
        for social in arrSocial {
            let network = social["network"]!
            socialId[network] = social["id"]!
        }
        self.socialId = socialId
        
        let history = json["history"] as! [[String:String]]
        for statusChange in history {
            let status = statusChange["status"]!
            switch status {
            case "pending":
                self.created = statusChange["creationDate"]!
            case "accepted":
                self.accepted = statusChange["creationDate"]!
            default: break
            }
        }
    }
}
