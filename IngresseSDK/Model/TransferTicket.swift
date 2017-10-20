//
//  TransferTicket.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransferTicket: JSONConvertible {
    public var id: Int = 0
    public var guestTypeId: Int = 0
    public var ticketTypeId: Int = 0
    public var name: String = ""
    public var type: String = ""
    public var desc: String = ""
    
    public override func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            if key == "description" {
                guard let str = value as? String else {
                    continue
                }
                
                self.desc = str
                continue
            }
            
            applyKey(key, value: value)
        }
    }
}
