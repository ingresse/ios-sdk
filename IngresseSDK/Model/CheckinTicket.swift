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
                guard let lastCheckin = json["lastCheckin"] as? [String:Any] else { continue }
                
                self.lastCheckinTimestamp = lastCheckin["timestamp"] as? Int ?? 0
                
                if let holderObj = lastCheckin["holder"] as? [String:Any] {
                    self.holder = SimpleUser()
                    self.holder?.applyJSON(holderObj)
                }
                
                if let operatorObj = lastCheckin["operator"] as? [String:Any] {
                    self.operatorUser = SimpleUser()
                    self.operatorUser?.applyJSON(operatorObj)
                }
                
                continue
            }
            
            if key == "owner" {
                guard let ownerObj = json[key] as? [String:Any] else { continue }
                
                self.owner = SimpleUser()
                self.owner?.applyJSON(ownerObj)
                
                continue
            }
            
            applyKey(key, json: json)
        }
    }
}


