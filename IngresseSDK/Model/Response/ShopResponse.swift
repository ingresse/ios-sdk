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
        }

        public struct Payment: Codable {
            public var boleto: String = ""
            public var message: String = ""
            public var status: String = ""
            public var tax: Double = 0
            public var total: Double = 0
            public var transactionId: String = ""
        }
    }
}

extension Response.Shop.Transaction {
    enum CodingKeys: String, CodingKey {
        case transactionId
        case status
        case availablePaymentMethods
        case message
    }

    enum PaymentMethodKeys: String, CodingKey {
        case CartaoCredito
    }

    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self)
            else { return }

        transactionId = container.decodeKey(.transactionId, ofType: String.self)
        status = container.decodeKey(.status, ofType: String.self)
        message = container.decodeKey(.message, ofType: String.self)

        guard let methods = try? container.nestedContainer(keyedBy: PaymentMethodKeys.self, forKey: .availablePaymentMethods)
            else { return }

        creditCard = methods.safeDecodeKey(.CartaoCredito, to: PaymentMethod.self)
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
    }

    public static func fromJSON(_ json: [String: Any]) -> Response.Shop.Payment? {
        return JSONDecoder().decodeDict(of: Response.Shop.Payment.self, from: json)
    }
}