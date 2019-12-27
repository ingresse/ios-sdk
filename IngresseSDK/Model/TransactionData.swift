//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionData: NSObject, Decodable {
    @objc public var id: String = ""
    @objc public var status: String = ""
    @objc public var transactionId: String = ""

    @objc public var operatorId: String = ""
    @objc public var salesgroupId: Int = 0

    @objc public var appId: Int = -1
    @objc public var paymenttype: String = ""
    @objc public var paymentoption: String = ""
    @objc public var paymentdetails: String = ""
    @objc public var creditCard: PaymentCard?

    @objc public var totalPaid: Double = 0
    @objc public var sumUp: Double = 0
    @objc public var paymentTax: Double = 0

    @objc public var interest: Int = 0
    @objc public var taxToCostumer: Int = 0
    @objc public var installments: Int = 0

    @objc public var creationdate: String = ""
    @objc public var modificationdate: String = ""

    @objc public var customer: User?
    @objc public var event: TransactionEvent?
    @objc public var session: TransactionSession?

    @objc public var bankbilletUrl: String = ""

    @objc public var token: String = ""

    @objc public var basket: TransactionBasket?
    
    @objc public var declinedReason: DeclinedReason?
    @objc public var payment: PaymentTransaction?

    @objc public var refund: Refund?
    @objc public var hasRefund: Bool {
        return refund != nil
    }
    
    @objc public var hasDeclined: Bool {
        return status == "declined"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case status
        case transactionId
        case operatorId
        case salesgroupId
        case appId = "app_id"
        case paymenttype
        case paymentoption
        case paymentdetails
        case creditCard
        case totalPaid
        case sumUp = "sum_up"
        case paymentTax
        case interest
        case taxToCostumer
        case installments
        case creationdate
        case modificationdate
        case customer
        case event
        case session
        case bankbilletUrl = "bankbillet_url"
        case token
        case basket
        case refund
        case payment
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        id = container.decodeKey(.id, ofType: String.self)
        status = container.decodeKey(.status, ofType: String.self)
        operatorId = container.decodeKey(.operatorId, ofType: String.self)
        salesgroupId = container.decodeKey(.salesgroupId, ofType: Int.self)
        transactionId = container.decodeKey(.transactionId, ofType: String.self)
        appId = container.decodeKey(.appId, ofType: Int.self)
        paymenttype = container.decodeKey(.paymenttype, ofType: String.self)
        paymentoption = container.decodeKey(.paymentoption, ofType: String.self)
        paymentdetails = container.decodeKey(.paymentdetails, ofType: String.self)
        bankbilletUrl = container.decodeKey(.bankbilletUrl, ofType: String.self)
        token = container.decodeKey(.token, ofType: String.self)
        totalPaid = container.decodeKey(.totalPaid, ofType: Double.self)
        sumUp = container.decodeKey(.sumUp, ofType: Double.self)
        paymentTax = container.decodeKey(.paymentTax, ofType: Double.self)
        interest = container.decodeKey(.interest, ofType: Int.self)
        taxToCostumer = container.decodeKey(.taxToCostumer, ofType: Int.self)
        installments = container.decodeKey(.installments, ofType: Int.self)
        creationdate = container.decodeKey(.creationdate, ofType: String.self)
        modificationdate = container.decodeKey(.modificationdate, ofType: String.self)

        customer = try container.decodeIfPresent(User.self, forKey: .customer)
        event = try container.decodeIfPresent(TransactionEvent.self, forKey: .event)
        session = try container.decodeIfPresent(TransactionSession.self, forKey: .session)
        refund = try container.decodeIfPresent(Refund.self, forKey: .refund)
        creditCard = try container.decodeIfPresent(PaymentCard.self, forKey: .creditCard)

        let jsonBasket = try? container.decodeIfPresent(TransactionBasket.self, forKey: .basket)

        let tickets = container.decodeKey(.basket, ofType: [TransactionTicket].self)
        let arrayBasket = JSONDecoder().decodeDict(of: TransactionBasket.self, from: ["tickets": []])
        arrayBasket?.tickets = tickets

        basket = jsonBasket ?? arrayBasket
        
        payment = try container.decodeIfPresent(PaymentTransaction.self, forKey: .payment)
        declinedReason = payment?.declinedReason
    }

    @objc public static func fromJSON(_ json: [String: Any]) -> TransactionData? {
        return JSONDecoder().decodeDict(of: TransactionData.self, from: json)
    }
}
