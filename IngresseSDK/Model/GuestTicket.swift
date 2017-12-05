//
//  Guest.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class GuestTicket: JSONConvertible {
    public var id: String = ""
    public var transactionId: String = ""
    public var code: String = ""
    public var userId: String = ""
    public var name: String = ""
    public var email: String = ""
    public var holderUserId: String = ""
    public var holderEmail: String = ""
    public var holderName: String = ""
    public var ticketId: String = ""
    public var ticket: String = ""
    public var type: String = ""
    public var guestTypeId: String = ""
    public var seatLocator: String = ""
    public var checked: String = ""
    public var lastUpdate: String = ""
    public var soldOnline: String = ""
    public var transferred: Bool = false
    
    public var isChecked: Bool {
        get {
            return checked == "1"
        }
    }
}
