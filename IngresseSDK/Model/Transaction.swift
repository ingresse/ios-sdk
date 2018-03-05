//
//  Transaction.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Transaction: NSObject, Codable {
    public var id: String = ""
    public var status: String = ""
    public var transactionId: String = ""

    public var operatorId: String = ""
    public var salesgroupId: Int = 0

    public var app_id: Int = -1
    public var paymenttype: String = ""
    public var paymentoption: String = ""
    public var paymentdetails: String = ""
    public var creditCard: PaymentCard?

    public var totalPaid: Double = 0.0
    public var sum_up: Double = 0.0
    public var paymentTax: Double = 0.0

    public var interest: Int = 0
    public var taxToCostumer: Int = 0
    public var installments: Int = 1

    public var creationdate: String = ""
    public var modificationdate: String = ""

    public var customer: User?
    public var event: TransactionEvent?
    public var session: TransactionSession?

    public var bankbillet_url: String = ""

    public var token: String = ""

    public var basket: Basket = Basket()

    public var refund: Refund?
    public var hasRefund: Bool {
        return refund != nil
    }

    public class Basket: NSObject, Codable {
        public var tickets: [TransactionTicket] = []
    }
}
