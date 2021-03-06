//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class EventAttributesTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String: Any]()
        json["accepted_apps"] = ["site", "android"]
        json["ticket_transfer_enabled"] = false
        json["ticket_transfer_required"] = true

        // When
        let obj = JSONDecoder().decodeDict(of: EventAttributes.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.acceptedApps[0], "site")
        XCTAssertEqual(obj?.acceptedApps[1], "android")
        XCTAssertEqual(obj?.transferEnabled, false)
        XCTAssertEqual(obj?.transferRequired, true)
    }

    func testFromJSON() {
        // Given
        var json = [String: Any]()
        json["accepted_apps"] = ["site", "android"]
        json["ticket_transfer_enabled"] = false
        json["ticket_transfer_required"] = true

        // When
        let obj = EventAttributes.fromJSON(json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.acceptedApps[0], "site")
        XCTAssertEqual(obj?.acceptedApps[1], "android")
        XCTAssertEqual(obj?.transferEnabled, false)
        XCTAssertEqual(obj?.transferRequired, true)
    }
}
