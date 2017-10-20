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
    public var transactionId: String = ""
    
    public var code: String = ""
    public var itemType: String = ""
    public var sequence: String = "00000"
    public var guestName: String?
    public var title: String = ""
    public var type: String = ""
    public var desc: String = ""
    public var checked: Bool = false
    
    public var sessions: [Session] = []
    
    public var eventId: Int = 0
    public var eventTitle: String = ""
    public var eventVenue: Venue = Venue()
    
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
            
            if key == "sessions" {
                guard
                    let sessionsObj = value as? [String:Any],
                    let data = sessionsObj["data"] as? [[String:Any]]
                    else { continue }
                
                self.sessions = []
                for item in data {
                    let session = Session()
                    session.applyJSON(item)
                    self.sessions.append(session)
                }
                
                continue
            }
            
            if key == "eventVenue" {
                guard let venue = value as? [String:Any] else { continue }
                
                self.eventVenue.applyJSON(venue)
                continue
            }
            
            if key == "description" {
                applyKey("desc", value: value)
                continue
            }
            
            applyKey(key, value: value)
        }
    }
}

