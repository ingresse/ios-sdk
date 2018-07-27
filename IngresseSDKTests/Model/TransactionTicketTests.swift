//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TransactionTicketTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String:Any]()
        json["id"] = 1
        json["code"] = "code"
        json["name"] = "name"
        json["ticket"] = "ticket"
        json["type"] = "type"
        json["ticketId"] = 2
        json["typeId"] = 3
        json["price"] = "price"
        json["tax"] = "tax"
        json["percentTax"] = 11
        json["lastUpdate"] = 99
        json["checked"] = true
        json["transferred"] = true

        // When
        let obj = JSONDecoder().decodeDict(of: TransactionTicket.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, 1)
        XCTAssertEqual(obj?.code, "code")
        XCTAssertEqual(obj?.name, "name")
        XCTAssertEqual(obj?.type, "type")
        XCTAssertEqual(obj?.ticket, "ticket")
        XCTAssertEqual(obj?.price, "price")
        XCTAssertEqual(obj?.tax, "tax")
        XCTAssertEqual(obj?.ticketId, 2)
        XCTAssertEqual(obj?.typeId, 3)
        XCTAssertEqual(obj?.percentTax, 11)
        XCTAssertEqual(obj?.lastUpdate, 99)
        XCTAssertEqual(obj?.checked, true)
        XCTAssertEqual(obj?.transferred, true)
    }
}
