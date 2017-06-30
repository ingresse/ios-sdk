//
//  Transaction.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Transaction: JSONConvertible {

    public var id: String                  = ""
    public var status: String              = ""
    public var transactionId: String       = ""

    public var operatorId: String          = ""
    public var salesgroupId: Int           = 0

    public var app_id: Int                 = -1
    public var paymenttype: String         = ""
    public var paymentoption: String       = ""
    public var paymentdetails: String      = ""
    public var creditCard: String          = ""

    public var totalPaid: Double           = 0.0
    public var sum_up: Double              = 0.0
    public var paymentTax: Double          = 0.0

    public var interest: Int               = 0
    public var taxToCostumer: Int          = 0
    public var installments: Int           = 1

    public var creationdate: String        = ""
    public var modificationdate: String    = ""

    public var customer: Customer          = Customer()
    public var event: TransactionEvent     = TransactionEvent()
    public var session: TransactionSession = TransactionSession()

    public var bankbillet_url: String      = ""

    public var token: String               = ""

    public var basket: [TransactionTicket] = []

    public var refund: Refund              = Refund()
    public var hasRefund: Bool             = false

    override public func applyJSON(_ json: [String : Any]) {
        for key:String in json.keys {

            if key == "event" {
                guard let event = json[key] as? [String:Any] else {
                    continue
                }

                self.event.applyJSON(event)
                continue
            }

            if key == "session" {
                guard let session = json[key] as? [String:Any] else {
                    continue
                }

                self.session.applyJSON(session)
                continue
            }

            if key == "customer" {
                guard let customer = json[key] as? [String:Any] else {
                    continue
                }

                self.customer.applyJSON(customer)
                continue
            }

            if key == "refund" {
                guard let refund = json[key] as? [String:Any] else {
                    continue
                }

                self.hasRefund = true

                self.refund.applyJSON(refund)
                continue
            }

            if key == "basket" {
                guard let tickets = json[key] as? [[String:Any]] else {
                    continue
                }

                for item in tickets {
                    let ticket = TransactionTicket()
                    ticket.applyJSON(item)

                    self.basket.append(ticket)
                }

                continue
            }

            if !self.responds(to: NSSelectorFromString(key)) {
                continue
            }

            let value = (json[key] is String ? (json[key] as? String)?.trim() : json[key])

            if (value is NSNull || value == nil) {
                continue
            }

            self.setValue(value, forKey: key)
        }
    }
}
