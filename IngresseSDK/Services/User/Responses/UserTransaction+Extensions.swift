//
//  Copyright © 2022 Ingresse. All rights reserved.
//

public extension UserTransactionResponse {

    struct Event: Decodable {
        public let id: Int
        public let title: String
        public let datetime: String
    }

    struct Items: Decodable {
        public let data: [Self.ItemsData]
        public let quantity: Int

        public struct ItemsData: Decodable {
            public let id: Int
            public let price: Double
            public let tax: Double
        }
    }

    struct Sale: Decodable {
        public let transactionId: String
        public let amount: Double
        public let status: String?
        public let payment: Self.Payment
        public let createdAt: String
        public let channel: String?
        public let canRefund: Bool

        public struct Payment: Decodable {
            public let method: String?
            public let acquirer: String?
            public let bank: Self.Bank?
            public let creditCard: Self.CreditCard?

            public struct CreditCard: Decodable {
                public let brand: String?
                public let lastDigits: String?
                public let installments: Int?
            }

            public struct Bank: Decodable {
                public let name: String?
                public let code: String?
            }
        }
    }
}
