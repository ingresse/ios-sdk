//
//  Transfer.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2016 Ingresse. All rights reserved.
//

import Foundation

public class Transfer: JSONConvertible {
    public var transferId: Int = 0
    public var userId: Int = 0
    public var status: String = ""
    public var email: String = ""
    public var name: String = ""
    public var picture: String = ""
    public var created: String = ""
    public var accepted: String = ""
    public var socialId: [String: String] = [:]
    
    public override func applyJSON(_ json: [String : Any]) {
        for key:String in json.keys {
            
            if key == "socialId" {
                guard let arrSocial = json["socialId"] as? [[String:String]] else { continue }
                
                for social in arrSocial {
                    guard let network = social["network"],
                        let id = social["id"]
                        else {
                            continue
                    }
                    
                    self.socialId[network] = id
                }
                
                continue
            }
            
            if key == "history" {
                guard let history = json["history"] as? [[String:String]] else { continue }
                
                for statusChange in history {
                    guard let status = statusChange["status"],
                        let date = statusChange["creationDate"]
                        else {
                            continue
                    }
                    
                    switch status {
                    case "pending":
                        self.created = date
                    case "accepted":
                        self.accepted = date
                    default: break
                    }
                }
                
                continue
            }
            
            applyKey(key, json: json)
        }
    }
}
