//
//  TransactionTicket.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionTicket: JSONConvertible {
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
    
    override public func applyJSON(_ json: [String : Any]) {
        for key:String in json.keys {
            
            if key == "checked" {
                guard let boolValue = json[key] as? String else { continue }
                
                self.checked = boolValue == "1"
                continue
            }
            
            applyKey(key, json: json)
        }
    }
}
