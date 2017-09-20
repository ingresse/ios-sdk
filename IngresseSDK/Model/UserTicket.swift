//
//  Ticket.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2016 Gondek. All rights reserved.
//

public class UserTicket: JSONConvertible {
    public var id: Int = 0
    public var guestTypeId: Int = 0
    public var ticketTypeId: Int = 0
    
    public var code: String?
    public var sequence: String = "00000"
    
    public var title: String = ""
    public var type: String = ""
    public var desc: String = ""
    public var checked: Bool = false
    
    public var sessionId: Int = 0
    public var transactionId: String = ""
    
    public var guestName: String?
    public var receivedFrom: Transfer?
    public var transferedTo: Transfer?
    
    public override func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            if ["receivedFrom", "transferedTo"].contains(key) {
                guard let transferObj = value as? [String:Any] else { continue }
                
                let transfer = Transfer()
                transfer.applyJSON(transferObj)
                
                switch key {
                case "receivedFrom": self.receivedFrom = transfer
                case "transferedTo": self.transferedTo = transfer
                default: break
                }
                
                continue
            }
            
            if key == "description" {
                self.desc = value as? String ?? ""
                continue
            }
            
            applyKey(key, value: value)
        }
    }
}

