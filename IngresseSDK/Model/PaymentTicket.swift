//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public struct PaymentTicket: Encodable {
    public var guestTypeId: String = ""
    public var quantity: Int = 0
    public var holder: [Holder] = []

    public struct Holder: Encodable {
        public var email: String = ""
        public init() {}
    }

    public init() {}
}
