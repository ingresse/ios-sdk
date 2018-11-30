//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class PaymentTicketTests: XCTestCase {

    func testEncodable() {
        // Given
        var holder = PaymentTicket.Holder()
        holder.email = "email"

        var paymentTicket = PaymentTicket()
        paymentTicket.guestTypeId = "guestTypeId"
        paymentTicket.quantity = 10
        paymentTicket.holder = [holder]

        // When
        let obj = try? JSONEncoder().encode(paymentTicket)
        let stringJson = String(data: obj!, encoding: .utf8)
        let expected = "{\"guestTypeId\":\"\(paymentTicket.guestTypeId)\",\"quantity\":\(paymentTicket.quantity),\"holder\":[{\"email\":\"\(holder.email)\"}]}"

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(stringJson, expected)
    }
}
