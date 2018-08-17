//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
import IngresseSDK

class ShopTicketTests: XCTestCase {

    func testInit() {
        // When
        let obj = ShopTicket(id: 0, name: "name",
                             fullDescription: "fullDescription",
                             guestTypeId: 0,
                             status: "status",
                             typeName: "typeName",
                             price: 0.0,
                             tax: 0.0,
                             hidden: false,
                             quantity: 1,
                             maximum: 1, minimum: 1)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj.id, 0)
        XCTAssertEqual(obj.name, "name")
        XCTAssertEqual(obj.fullDescription, "fullDescription")
        XCTAssertEqual(obj.guestTypeId, 0)
        XCTAssertEqual(obj.status, "status")
        XCTAssertEqual(obj.typeName, "typeName")
        XCTAssertEqual(obj.price, 0.0)
        XCTAssertEqual(obj.tax, 0.0)
        XCTAssertEqual(obj.hidden, false)
        XCTAssertEqual(obj.quantity, 1)
        XCTAssertEqual(obj.maximum, 1)
        XCTAssertEqual(obj.minimum, 1)
    }
}
