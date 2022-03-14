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
        public let status: Self.Status
        public let payment: Self.Payment
        public let createdAt: String
        public let canRefund: Bool

        public enum Status: String, Decodable {
            case approved = "approved"
            case authorized = "authorized"
            case declined = "declined"
            case error = "error"
            case manualReview = "manual review"
            case pending = "pending"
            case refund = "refund"
        }

        public struct Payment: Decodable {
            public let method: String
            public let creditCard: Self.CreditCard

            public struct CreditCard: Decodable {
                public let lastDigits: String
            }
        }
    }
}
