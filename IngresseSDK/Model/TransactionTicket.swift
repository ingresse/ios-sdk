//
//  TransactionTicket.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionTicket: NSObject, Codable {
    public var id: Int = 0
    
    public var code: String = ""
    public var name: String = ""
    public var checked: Bool = false
    public var lastUpdate: Int = 0
    
    public var transferred: Bool = false
    
    public var ticket: String = ""
    public var type: String = ""
    public var ticketId: Int = 0
    public var typeId: Int = 0
    
    public var price: String = ""
    public var tax: String = ""
    public var percentTax: Int = 0
}
