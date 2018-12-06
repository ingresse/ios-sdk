//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class SessionTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String: Any]()
        json["id"] = 999
        json["datetime"] = "2018-01-01T00:00:00+00:00"

        // When
        let session = JSONDecoder().decodeDict(of: Session.self, from: json)

        // Then
        XCTAssertNotNil(session)
        XCTAssertEqual(session?.id, 999)
        XCTAssertEqual(session?.timestamp, "2018-01-01T00:00:00+00:00")

        let expectedDate = "2018-01-01T00:00:00+00:00".toDate()
        XCTAssertEqual(session?.date, expectedDate)
    }
    
    func testDecodeDateTime() {
        // Given
        var json = [String: Any]()
        json["timestamp"] = "2018-01-01T00:00:00+00:00"

        // When
        let datetime = JSONDecoder().decodeDict(of: Session.DateTime.self, from: json)

        // Then
        XCTAssertNotNil(datetime)
        XCTAssertEqual(datetime?.timestamp, "2018-01-01T00:00:00+00:00")

        let expectedDate = "2018-01-01T00:00:00+00:00".toDate()
        XCTAssertEqual(datetime?.dateTime, expectedDate)
        let stringDate = expectedDate.toString(format: .dateHourAt)
        XCTAssertEqual(datetime?.date, stringDate)
    }
}
