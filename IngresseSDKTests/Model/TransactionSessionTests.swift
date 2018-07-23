//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TransactionSessionTests: XCTestCase {
    
    func testDecodeTimestamp() {
        // Given
        var json = [String:Any]()
        json["id"] = "1"
        json["dateTime"] = [
            "date": "01/01/2018",
            "time": "00:00",
            "timestamp": "timestamp"
        ]

        // When
        let obj = JSONDecoder().decodeDict(of: TransactionSession.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, "1")
        XCTAssertEqual(obj?.dateTime?.date, "01/01/2018")
        XCTAssertEqual(obj?.dateTime?.time, "00:00")
        XCTAssertEqual(obj?.dateTime?.timestamp, "timestamp")
    }
    
    func testDecodeDateTime() {
        // Given
        var json = [String:Any]()
        json["id"] = "2"
        json["dateTime"] = [
            "date": "02/01/2018",
            "time": "01:00",
            "dateTime": "timestamp"
        ]

        // When
        let obj = JSONDecoder().decodeDict(of: TransactionSession.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, "2")
        XCTAssertEqual(obj?.dateTime?.date, "02/01/2018")
        XCTAssertEqual(obj?.dateTime?.time, "01:00")
        XCTAssertEqual(obj?.dateTime?.timestamp, "timestamp")
    }
}
