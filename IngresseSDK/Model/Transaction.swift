//
//  Transaction.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Transaction: NSObject, Decodable {
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

    public var basket: TransactionBasket?

    public var refund: Refund?
    public var hasRefund: Bool {
        return refund != nil
    }

    enum CodingKeys: String, CodingKey {
        case id
        case status
        case transactionId
        case operatorId
        case salesgroupId
        case app_id
        case paymenttype
        case paymentoption
        case paymentdetails
        case creditCard
        case totalPaid
        case sum_up
        case paymentTax
        case interest
        case taxToCostumer
        case installments
        case creationdate
        case modificationdate
        case customer
        case event
        case session
        case bankbillet_url
        case token
        case basket
        case refund
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        operatorId = try container.decodeIfPresent(String.self, forKey: .operatorId) ?? ""
        salesgroupId = try container.decodeIfPresent(Int.self, forKey: .salesgroupId) ?? 0
        transactionId = try container.decodeIfPresent(String.self, forKey: .transactionId) ?? ""
        app_id = try container.decodeIfPresent(Int.self, forKey: .app_id) ?? -1
        paymenttype = try container.decodeIfPresent(String.self, forKey: .paymenttype) ?? ""
        paymentoption = try container.decodeIfPresent(String.self, forKey: .paymentoption) ?? ""
        paymentdetails = try container.decodeIfPresent(String.self, forKey: .paymentdetails) ?? ""
        creditCard = try container.decodeIfPresent(PaymentCard.self, forKey: .creditCard)
        totalPaid = try container.decodeIfPresent(Double.self, forKey: .totalPaid) ?? 0.0
        sum_up = try container.decodeIfPresent(Double.self, forKey: .sum_up) ?? 0.0
        paymentTax = try container.decodeIfPresent(Double.self, forKey: .paymentTax) ?? 0.0
        interest = try container.decodeIfPresent(Int.self, forKey: .interest) ?? 0
        taxToCostumer = try container.decodeIfPresent(Int.self, forKey: .taxToCostumer) ?? 0
        installments = try container.decodeIfPresent(Int.self, forKey: .installments) ?? 1
        creationdate = try container.decodeIfPresent(String.self, forKey: .creationdate) ?? ""
        modificationdate = try container.decodeIfPresent(String.self, forKey: .modificationdate) ?? ""
        customer = try container.decodeIfPresent(User.self, forKey: .customer)
        event = try container.decodeIfPresent(TransactionEvent.self, forKey: .event)
        session = try container.decodeIfPresent(TransactionSession.self, forKey: .session)
        bankbillet_url = try container.decodeIfPresent(String.self, forKey: .bankbillet_url) ?? ""
        token = try container.decodeIfPresent(String.self, forKey: .token) ?? ""
        basket = try container.decodeIfPresent(TransactionBasket.self, forKey: .basket)
        refund = try container.decodeIfPresent(Refund.self, forKey: .refund)
    }

    public static func fromJSON(_ json: [String: Any]) -> Transaction? {
        return JSONDecoder().decodeDict(of: Transaction.self, from: json)
    }
}
