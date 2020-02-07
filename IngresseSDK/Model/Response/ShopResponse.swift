//
//  Copyright © 2018 Ingresse. All rights reserved.
//

extension Response {
    public struct Shop {
        public struct Transaction: Decodable {
            public var transactionId: String = ""
            public var status: String = ""
            public var creditCard: PaymentMethod?
            public var message: String = ""
            public var insurance: Insurance?
            public var discountAmount: Double = 0
            public var finalAmount: Double = 0
            public var sumUp: Double = 0
        }

        public struct Payment: Codable {
            public var boleto: String = ""
            public var message: String = ""
            public var status: String = ""
            public var tax: Double = 0
            public var total: Double = 0
            public var transactionId: String = ""
            public var declinedReason: DeclinedReason?
        }

        public struct Methods: Decodable {
            public var creditCard: PaymentMethod?
            public var creditCardToken: PaymentMethod?
        }
    }
}

extension Response.Shop.Transaction {
    enum CodingKeys: String, CodingKey {
        case transactionId
        case status
        case availablePaymentMethods
        case message
        case insurance
        case discountAmount
        case finalAmount
        case sumUp
    }

    enum PaymentMethodKeys: String, CodingKey {
        case creditCard = "CartaoCredito"
    }

    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self)
            else { return }

        transactionId = container.decodeKey(.transactionId, ofType: String.self)
        status = container.decodeKey(.status, ofType: String.self)
        message = container.decodeKey(.message, ofType: String.self)
        insurance = try? container.decodeIfPresent(Insurance.self, forKey: .insurance)
        discountAmount = container.decodeKey(.discountAmount, ofType: Double.self)
        finalAmount = container.decodeKey(.finalAmount, ofType: Double.self)
        sumUp = container.decodeKey(.sumUp, ofType: Double.self)

        guard let methods = try? container.nestedContainer(keyedBy: PaymentMethodKeys.self, forKey: .availablePaymentMethods)
            else { return }

        creditCard = methods.safeDecodeKey(.creditCard, to: PaymentMethod.self)
    }
}

extension Response.Shop.Payment {
    enum CodingKeys: String, CodingKey {
        case boleto
        case message
        case status
        case tax
        case total
        case transactionId
        case declinedReason
    }

    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self)
            else { return }
        boleto = container.decodeKey(.boleto, ofType: String.self)
        message = container.decodeKey(.message, ofType: String.self)
        status = container.decodeKey(.status, ofType: String.self)
        tax = container.decodeKey(.tax, ofType: Double.self)
        total = container.decodeKey(.total, ofType: Double.self)
        transactionId = container.decodeKey(.transactionId, ofType: String.self)
        declinedReason = try container.decodeIfPresent(DeclinedReason.self, forKey: .declinedReason)
    }

    public static func fromJSON(_ json: [String: Any]) -> Response.Shop.Payment? {
        return JSONDecoder().decodeDict(of: Response.Shop.Payment.self, from: json)
    }
}

extension Response.Shop.Methods {
    enum CodingKeys: String, CodingKey {
        case creditCard = "CartaoCredito"
        case creditCardToken
    }

    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self)
            else { return }

        creditCard = container.decodeKey(.creditCard, ofType: PaymentMethod.self)
        creditCardToken = container.decodeKey(.creditCardToken, ofType: PaymentMethod.self)
    }
}
