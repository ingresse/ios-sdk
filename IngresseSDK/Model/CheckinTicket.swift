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
    
    public var owner: User? = nil
    public var holder: User? = nil
    public var operatorUser: User? = nil
    
    override public func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            if key == "lastCheckin" {
                guard let lastCheckin = value as? [String:Any] else { continue }
                
                self.lastCheckinTimestamp = lastCheckin["timestamp"] as? Int ?? 0
                
                if let holderObj = lastCheckin["holder"] as? [String:Any] {
                    self.holder = User()
                    self.holder?.applyJSON(holderObj)
                }
                
                if let operatorObj = lastCheckin["operator"] as? [String:Any] {
                    self.operatorUser = User()
                    self.operatorUser?.applyJSON(operatorObj)
                }
                
                continue
            }
            
            if key == "owner" {
                guard let ownerObj = value as? [String:Any] else { continue }
                
                self.owner = User()
                self.owner?.applyJSON(ownerObj)
                
                continue
            }
            
            applyKey(key, value: value)
        }
    }
}


