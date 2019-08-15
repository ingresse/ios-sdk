//
//  Copyright © 2018 Ingresse. All rights reserved.
//

extension Request {
    public struct Shop: Encodable {
        public struct Create: Encodable {
            public var userId: String = ""
            public var eventId: String = ""
            public var passkey: String?
            public var tickets: [PaymentTicket] = []

            public init() {}
        }

        public struct CreditCard: Encodable {
            public var number: String = ""
            public var holderName: String = ""
            public var expiracyMonth: String = ""
            public var expiracyYear: String = ""
            public var cvv: String = ""
            public var save: Bool = false

            public init() {}
        }

        public struct Free: Encodable {
            public var userId: String = ""
            public var eventId: String = ""
            public var transactionId: String = ""
            public var document: String = ""
            public var postback: String = ""
            public var ingeprefsPayload: String = ""

            public init() {}
        }

        public struct Payment: Encodable {
            public var userId: String = ""
            public var eventId: String = ""
            public var transactionId: String = ""
            public var creditcard: CreditCard?
            public var installments: Int = 0
            public var paymentMethod: String = ""
            public var document: String = ""
            public var postback: String = ""
            public var ingeprefsPayload: String = ""
            public var source: String = "mobile"
            public var hdim: String = ""

            public init() {}
        }
    }
}
