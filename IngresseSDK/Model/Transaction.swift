//
//  Transaction.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Transaction: JSONConvertible {
    public var id: String = ""
    public var status: String = ""
    public var transactionId: String = ""
    
    public var operatorId: String = ""
    public var salesgroupId: Int = 0
    
    public var app_id: Int = -1
    public var paymenttype: String = ""
    public var paymentoption: String = ""
    public var paymentdetails: String = ""
    public var creditCard: String = ""
    
    public var totalPaid: Double = 0.0
    public var sum_up: Double = 0.0
    public var paymentTax: Double = 0.0
    
    public var interest: Int = 0
    public var taxToCostumer: Int = 0
    public var installments: Int = 1
    
    public var creationdate: String = ""
    public var modificationdate: String = ""
    
    public var customer: Customer = Customer()
    public var event: TransactionEvent = TransactionEvent()
    public var session: TransactionSession = TransactionSession()
    
    public var bankbillet_url: String = ""
    
    public var token: String = ""
    
    public var basket: [TransactionTicket] = []
    
    public var refund: Refund = Refund()
    public var hasRefund: Bool = false
    
    override public func applyJSON(_ json: [String : Any]) {
        for key:String in json.keys {
            
            if ["event", "session", "customer", "refund"].contains(key) {
                guard let obj = json[key] as? [String:Any] else { continue }
                
                switch key {
                case "event": self.event.applyJSON(obj)
                case "session": self.session.applyJSON(obj)
                case "customer": self.customer.applyJSON(obj)
                case "refund":
                    self.hasRefund = true
                    self.refund.applyJSON(obj)
                default: continue
                }
                
                continue
            }
            
            if key == "basket" {
                guard
                    let basket = json[key] as? [String:Any],
                    let tickets = basket["tickets"] as? [[String:Any]]
                    else {
                        continue
                }
                
                for item in tickets {
                    let ticket = TransactionTicket()
                    ticket.applyJSON(item)
                    
                    self.basket.append(ticket)
                }
                
                continue
            }
            
            applyKey(key, json: json)
        }
    }
}
