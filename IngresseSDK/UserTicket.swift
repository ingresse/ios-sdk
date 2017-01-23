//
//  Ticket.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2016 Gondek. All rights reserved.
//

import Foundation

public class UserTicket {
    public var checked       : Bool
    public var guestTypeId   : String
    public var ticketTypeId  : String
    public var saleTicketId  : String
    public var sequence      : String
    public var sessionId     : String
    public var code          : String?
    public var title         : String
    public var type          : String
    public var desc          : String
    public var transactionId : String
    public var seatLocator   : String?
    public var guestName     : String?
    public var receivedFrom  : Transfer?
    public var transferedTo  : Transfer?
    
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

