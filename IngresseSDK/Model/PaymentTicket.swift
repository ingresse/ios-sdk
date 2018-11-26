//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public struct PaymentTicket: Encodable {
    public var guestTypeId: String = ""
    public var quantity: Int = 0
    public var holder: String = ""

    public init() {}
}
