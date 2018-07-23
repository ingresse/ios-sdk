//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TransferTicketTests: XCTestCase {

    func testDecode() {
        // Given
        var json = [String: Any]()
        json["id"] = 1
        json["guestTypeId"] = 2
        json["ticketTypeId"] = 3
        json["description"] = "description"
        json["name"] = "name"
        json["type"] = "type"

        // When
        let obj = JSONDecoder().decodeDict(of: TransferTicket.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, 1)
        XCTAssertEqual(obj?.guestTypeId, 2)
        XCTAssertEqual(obj?.ticketTypeId, 3)
        XCTAssertEqual(obj?.desc, "description")
        XCTAssertEqual(obj?.name, "name")
        XCTAssertEqual(obj?.type, "type")
    }
}
