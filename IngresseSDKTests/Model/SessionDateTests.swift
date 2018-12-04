//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class SessionDateTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String: Any]()
        json["date"] = "date"
        json["time"] = "time"
        json["dateTime"] = "dateTime"

        // When
        let obj = JSONDecoder().decodeDict(of: SessionDate.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.date, "date")
        XCTAssertEqual(obj?.time, "time")
        XCTAssertEqual(obj?.dateTime, "dateTime")
    }
}
