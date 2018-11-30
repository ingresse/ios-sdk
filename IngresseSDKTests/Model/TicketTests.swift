//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TicketTests: XCTestCase {

    func testDecode() {
        // Given
        let ticketDate = ["id": 0,
                    "date": "date",
                    "time": "time",
                    "dateTime": "dateTime"] as [String : Any]

        let json = ["id": 0,
                    "name": "name",
                    "description": "desc",
                    "price": 2.0,
                    "tax": 2.0,
                    "beginSales": "beginSales",
                    "endSales": "endSales",
                    "status": "status",
                    "restrictions": ["max": 1],
                    "hidden": false,
                    "dates": [ticketDate]] as [String : Any]

        // When
        let obj = JSONDecoder().decodeDict(of: Ticket.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, 0)
        XCTAssertEqual(obj?.name, "name")
        XCTAssertEqual(obj?.desc, "desc")
        XCTAssertEqual(obj?.price, 2.0)
        XCTAssertEqual(obj?.tax, 2.0)
        XCTAssertEqual(obj?.beginSales, "beginSales")
        XCTAssertEqual(obj?.endSales, "endSales")
        XCTAssertEqual(obj?.status, "status")
        XCTAssertEqual(obj?.restrictions["max"], 1)
        XCTAssertFalse((obj?.hidden)!)
        XCTAssertEqual(obj?.dates.first!.id, 0)
        XCTAssertEqual(obj?.dates.first!.date, "date")
        XCTAssertEqual(obj?.dates.first!.time, "time")
        XCTAssertEqual(obj?.dates.first!.dateTime, "dateTime")
    }
}
