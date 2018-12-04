//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TicketDateTests: XCTestCase {

    func testDecode() {
        // Given
        let json = ["id": 0,
                    "date": "date",
                    "time": "time",
                    "dateTime": "dateTime"] as [String: Any]

        // When
        let obj = JSONDecoder().decodeDict(of: TicketDate.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, 0)
        XCTAssertEqual(obj?.date, "date")
        XCTAssertEqual(obj?.time, "time")
        XCTAssertEqual(obj?.dateTime, "dateTime")
    }
}
