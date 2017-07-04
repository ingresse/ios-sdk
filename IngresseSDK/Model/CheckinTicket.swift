//
//  CheckinTicket.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/25/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class CheckinTicket: JSONConvertible {
    public var code: String = ""
    public var status: Int = -1
    public var checked: Int = -1
    public var lastUpdate: Int = 0
    public var lastCheckinTimestamp: Int = 0
    
    public var owner: SimpleUser? = nil
    public var holder: SimpleUser? = nil
    public var operatorUser: SimpleUser? = nil
    
    override public func applyJSON(_ json: [String : Any]) {
        for key:String in json.keys {
            
            if key == "lastCheckin" {
                guard let lastCheckin = json["lastCheckin"] as? [String:Any] else {
                    continue
                }
                
                for lcKey:String in lastCheckin.keys {
                    if lcKey == "timestamp" {
                        self.lastCheckinTimestamp = lastCheckin[lcKey] as? Int ?? 0
                        
                        continue
                    }
                    
                    if lcKey == "holder" {
                        guard let holderObj = lastCheckin[lcKey] as? [String:Any] else {
                            continue
                        }
                        
                        self.holder = SimpleUser()
                        self.holder?.applyJSON(holderObj)
                        
                        continue
                    }
                    
                    if lcKey == "operator" {
                        guard let operatorObj = lastCheckin[lcKey] as? [String:Any] else {
                            continue
                        }
                        
                        self.operatorUser = SimpleUser()
                        self.operatorUser?.applyJSON(operatorObj)
                        
                        continue
                    }
                }
            }
            
            if key == "owner" {
                guard let ownerObj = json[key] as? [String:Any] else {
                    continue
                }
                
                self.owner = SimpleUser()
                self.owner?.applyJSON(ownerObj)
                
                continue
            }
            
            if !self.responds(to: NSSelectorFromString(key)) {
                continue
            }
            
            let value = (json[key] is String ? (json[key] as? String)?.trim() : json[key])
            
            if (value is NSNull || value == nil) {
                continue
            }
            
            self.setValue(value, forKey: key)
        }
    }
}


