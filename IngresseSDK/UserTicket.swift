//
//  Ticket.swift
//  TicketsShare-Prototype
//
//  Created by Rubens Gondek on 4/22/16.
//  Copyright © 2016 Gondek. All rights reserved.
//

import Foundation

public class UserTicket {
    var checked       : Bool
    var guestTypeId   : String
    var ticketTypeId  : String
    var saleTicketId  : String
    var sequence      : String
    var sessionId     : String
    var code          : String?
    var title         : String
    var type          : String
    var desc          : String
    var transactionId : String
    var seatLocator   : String?
    var guestName     : String?
    var receivedFrom  : Transfer?
    var transferedTo  : Transfer?
    
    init(withJSON json: [String:Any]) {
        let id = String(json["id"] as! Int)
        
        self.saleTicketId = id
        self.guestTypeId = String(json["guestTypeId"] as! Int)
        self.ticketTypeId = String(json["ticketTypeId"] as! Int)
        self.code = json["code"] as? String
        self.title = json["title"] as! String
        self.type = json["type"] as! String
        self.desc = json["description"] as! String
        self.sequence = json["sequence"] as? String ?? "00000"
        self.sessionId = String(json["sessionId"] as! Int)
        self.transactionId = json["transactionId"] as! String
        self.seatLocator = json["seat"] as? String
        self.checked = json["checked"] as! Bool
        self.guestName = json["renamedTo"] as? String
        
        if let received = json["receivedFrom"] as? [String:Any] {
            self.receivedFrom = Transfer(withJSON: received)
        }
        if let transfer = json["transferedTo"] as? [String:Any] {
            self.transferedTo = Transfer(withJSON: transfer)
        }

    }
}

