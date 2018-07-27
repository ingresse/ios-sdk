//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class CheckinSessionTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String: Any]()
        json["session"] = [
            "id": 1,
            "dateTime": [
                "date": "date",
                "time": "time",
                "dateTime": "dateTime"
            ]]
        json["owner"] = [:]
        json["lastStatus"] = [:]

        // When
        let obj = JSONDecoder().decodeDict(of: CheckinSession.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.session?.id, 1)
        XCTAssertEqual(obj?.session?.dateTime?.date, "date")
        XCTAssertEqual(obj?.session?.dateTime?.time, "time")
        XCTAssertEqual(obj?.session?.dateTime?.dateTime, "dateTime")
    }
}
