//
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

    public var totalPaid: Double = 0
    public var sum_up: Double = 0
    public var paymentTax: Double = 0

    public var interest: Int = 0
    public var taxToCostumer: Int = 0
    public var installments: Int = 0

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
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

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
        totalPaid = container.safeDecodeTo(Double.self, forKey: .totalPaid) ?? 0.0
        sum_up = container.safeDecodeTo(Double.self, forKey: .sum_up) ?? 0.0
        paymentTax = container.safeDecodeTo(Double.self, forKey: .paymentTax) ?? 0.0
        interest = container.safeDecodeTo(Int.self, forKey: .interest) ?? 0
        taxToCostumer = container.safeDecodeTo(Int.self, forKey: .taxToCostumer) ?? 0
        installments = container.safeDecodeTo(Int.self, forKey: .installments) ?? 1
        creationdate = try container.decodeIfPresent(String.self, forKey: .creationdate) ?? ""
        modificationdate = try container.decodeIfPresent(String.self, forKey: .modificationdate) ?? ""
        customer = try container.decodeIfPresent(User.self, forKey: .customer)
        event = try container.decodeIfPresent(TransactionEvent.self, forKey: .event)
        session = try container.decodeIfPresent(TransactionSession.self, forKey: .session)
        bankbillet_url = try container.decodeIfPresent(String.self, forKey: .bankbillet_url) ?? ""
        token = try container.decodeIfPresent(String.self, forKey: .token) ?? ""
        refund = try container.decodeIfPresent(Refund.self, forKey: .refund)

        if let jsonBasket = try? container.decodeIfPresent(TransactionBasket.self, forKey: .basket) {
            basket = jsonBasket
        } else {
            let tickets = try? container.decodeIfPresent([TransactionTicket].self, forKey: .basket) ?? []
            let json = tickets ?? []
            basket = JSONDecoder().decodeDict(of: TransactionBasket.self, from: ["tickets": json])
        }
    }

    public static func fromJSON(_ json: [String: Any]) -> Transaction? {
        return JSONDecoder().decodeDict(of: Transaction.self, from: json)
    }
}
