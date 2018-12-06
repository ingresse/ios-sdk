//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class GuestTicketTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String: Any]()
        json["id"] = "999"
        json["transactionId"] = "transactionId"
        json["code"] = "00.0000.?00000?.000.00"
        json["userId"] = "userId"
        json["name"] = "name"
        json["email"] = "email"
        json["holderUserId"] = "holderUserId"
        json["holderEmail"] = "holderEmail"
        json["holderName"] = "holderName"
        json["ticketId"] = "ticketId"
        json["ticket"] = "ticket"
        json["type"] = "type"
        json["guestTypeId"] = "guestTypeId"
        json["seatLocator"] = "seatLocator"
        json["checked"] = "1"
        json["lastUpdate"] = "lastUpdate"
        json["soldOnline"] = "1"
        json["transferred"] = true

        // When
        let obj = JSONDecoder().decodeDict(of: GuestTicket.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, "999")
        XCTAssertEqual(obj?.transactionId, "transactionId")
        XCTAssertEqual(obj?.code, "00.0000.?00000?.000.00")
        XCTAssertEqual(obj?.userId, "userId")
        XCTAssertEqual(obj?.name, "name")
        XCTAssertEqual(obj?.email, "email")
        XCTAssertEqual(obj?.holderUserId, "holderUserId")
        XCTAssertEqual(obj?.holderEmail, "holderEmail")
        XCTAssertEqual(obj?.holderName, "holderName")
        XCTAssertEqual(obj?.ticketId, "ticketId")
        XCTAssertEqual(obj?.ticket, "ticket")
        XCTAssertEqual(obj?.type, "type")
        XCTAssertEqual(obj?.name, "name")
        XCTAssertEqual(obj?.name, "name")
        XCTAssertEqual(obj?.guestTypeId, "guestTypeId")
        XCTAssertEqual(obj?.seatLocator, "seatLocator")
        XCTAssertEqual(obj?.checked, true)
        XCTAssertEqual(obj?.lastUpdate, "lastUpdate")
        XCTAssertEqual(obj?.soldOnline, "1")
        XCTAssertEqual(obj?.transferred, true)
    }
}
