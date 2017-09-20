//
//  Transfer.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2016 Ingresse. All rights reserved.
//

public class Transfer: JSONConvertible {
    public var transferId: Int = 0
    public var userId: Int = 0
    public var status: String = ""
    public var email: String = ""
    public var name: String = ""
    public var type: String = ""
    public var picture: String = ""
    public var created: String = ""
    public var accepted: String = ""
    public var socialId: [SocialAccount] = []
    
    public override func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            if key == "socialId" {
                guard let arrSocial = value as? [[String:String]] else { continue }

                self.socialId = []
                
                for social in arrSocial {
                    let account = SocialAccount()
                    account.applyJSON(social)
                    
                    self.socialId.append(account)
                }
                
                continue
            }
            
            if key == "history" {
                guard let history = value as? [[String:String]] else { continue }
                
                for statusChange in history {
                    guard let status = statusChange["status"],
                        let date = statusChange["creationDate"]
                        else {
                            continue
                    }
                    
                    switch status {
                    case "pending": self.created = date
                    case "accepted": self.accepted = date
                    default: break
                    }
                }
                
                continue
            }
            
            applyKey(key, value: value)
        }
    }
}
