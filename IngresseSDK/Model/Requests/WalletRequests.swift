//
//  Created by Rubens Gondek on 17/12/18.
//

extension Request {
    public struct Wallet {
        public struct NumberOfTickets: Encodable {
            public var eventId: Int = -1
            public var userId: Int = -1
            public var userToken: String = ""

            public init() {}
        }
    }
}
