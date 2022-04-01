//
//  Copyright © 2022 Ingresse. All rights reserved.
//

import Foundation

public struct TransactionRefundedResponse: Decodable {
    public let id: String
    public let externalId: String?
    public let paymentoption: String?
    public let paymenttype: String?
    public let installments: String?
    public let bankbilletURL: String?
    public let paymentdetails: String?
    public let transactionId: String?
    public let token: String?
    public let status: String?
    public let totalOrder: String?
    public let totalPaid: String?
    public let sumUp: String?
    public let paymentTax: String?
    public let interest: String?
    public let appId: Int?
    public let postbackURL: String?
    public let creationdate: String?
    public let modificationdate: String?
    public let operatorId: String?
    public let salesgroupId: Int?
    public let creditCard: Self.CreditCard?
    public let saleChannel: String?
    public let refundableUntil: String?
    public let basket: Self.Basket?
    public let customer: Self.Customer?
    public let event: Self.Event?
    public let responseOperator: Self.Customer?
    public let refund: Self.Refund?
    public let session: Self.Session?

    public enum CodingKeys: String, CodingKey {
        case id
        case externalId
        case paymentoption
        case paymenttype
        case installments
        case bankbilletURL = "bankbillet_url"
        case paymentdetails
        case transactionId
        case token
        case status
        case totalOrder
        case totalPaid
        case sumUp = "sum_up"
        case paymentTax
        case interest
        case appId = "app_id"
        case postbackURL = "postbackUrl"
        case creationdate
        case modificationdate
        case operatorId
        case salesgroupId
        case creditCard
        case saleChannel
        case refundableUntil
        case basket
        case customer
        case event
        case responseOperator = "operator"
        case refund
        case session
    }
}
