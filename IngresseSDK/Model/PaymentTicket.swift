//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class PaymentTicket: Encodable {
    public var guestTypeId: String = ""
    public var quantity: Int = 0

    public init(guestTypeId: String, quantity: Int) {
        self.guestTypeId = guestTypeId
        self.quantity = quantity
    }
}
