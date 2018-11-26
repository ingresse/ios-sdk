//
//  Copyright © 2018 Ingresse. All rights reserved.
//

extension Request {
    public struct Shop: Encodable {
        public struct Create: Encodable {
            public var userId: String = ""
            public var eventId: String = ""
            public var tickets: [PaymentTicket] = []

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

        }
    }
}
