//
//  Copyright © 2022 Ingresse. All rights reserved.
//

extension TransactionRefundedResponse {

    // MARK: - Basket
    public struct Basket: Decodable {
        public let tickets: [Self.Ticket]?

        public struct Ticket: Decodable {
            public let id: String?
            public let code: String?
            public let name: String?
            public let price: String?
            public let tax: String?
            public let ticketId: String?
            public let ticket: String?
            public let typeId: String?
            public let type: String?
            public let percentTax: String?
            public let transferred: Bool
            public let itemType: String?
            public let sessions: [Self.Session]?

            // MARK: - Session
            public struct Session: Decodable {
                public let id: Int
                public let dateTime: Self.DateTimeDetails?

                public struct DateTimeDetails: Decodable {
                    public let date: String?
                    public let time: String?
                    public let dateTime: String?
                }
            }
        }
    }

    // MARK: - Session
    public struct Session: Decodable {
        public let id: String
        public let dateTime: Self.DateTimeDetails?

        public struct DateTimeDetails: Decodable {
            public let date: String?
            public let time: String?
            public let timestamp: String?
        }
    }

    // MARK: - Customer
    public struct Customer: Decodable {
        public let id: Int
        public let email: String?
        public let username: String?
        public let name: String?
        public let ddi: String?
        public let phone: String?
        public let picture: String?
        public let birthdate: String?
        public let gender: String?
    }

    // MARK: - Event
    public struct Event: Decodable {
        public let id: String?
        public let title: String?
        public let type: String?
        public let status: String?
        public let saleEnabled: String?
        public let link: String?
        public let taxToCostumer: String?
        public let poster: String?
        public let venue: Self.Venue?

        public struct Venue: Decodable {
            public let name: String?
        }
    }

    // MARK: - CreditCard
    public struct CreditCard: Decodable {
        public let firstDigits: String?
        public let lastDigits: String?
    }

    // MARK: - Refund
    public struct Refund: Decodable {
        public let date: String?
        public let refundOperator: String?
        public let reason: String?

        public enum CodingKeys: String, CodingKey {
            case date
            case refundOperator = "operator"
            case reason
        }
    }
}
