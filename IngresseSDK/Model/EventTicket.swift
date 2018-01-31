//
//  EventTicket.swift
//  IngresseSDK
//
//  Created by Marcelo Bissuh on 10/10/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class EventTicket: JSONConvertible {
    
    public var id: Int = 0
    public var guestTypeId: Int = 0
    public var ticketTypeId: Int = 0
    public var name: String = ""
    public var desc: String = ""
    public var status: String = ""
    public var price: Double = 0.0
    
    public override func applyJSON(_ json: [String:Any]) {
        for (key,value) in json {
            if key == "description" {
                self.applyKey("desc", value: value)
                continue
            }
            
            self.applyKey(key, value: value)
        }
    }
}
