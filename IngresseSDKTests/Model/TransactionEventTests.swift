//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TransactionEventTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String: Any]()
        json["id"] = "1"
        json["title"] = "title"
        json["type"] = "type"
        json["status"] = "status"
        json["link"] = "link"
        json["poster"] = "poster"
        json["venue"] = ["name": "venueName"]
        json["saleEnabled"] = true
        json["taxToCostumer"] = 99

        // When
        let obj = JSONDecoder().decodeDict(of: TransactionEvent.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, "1")
        XCTAssertEqual(obj?.title, "title")
        XCTAssertEqual(obj?.link, "link")
        XCTAssertEqual(obj?.type, "type")
        XCTAssertEqual(obj?.poster, "poster")
        XCTAssertEqual(obj?.status, "status")
        XCTAssertEqual(obj?.taxToCostumer, 99)
        XCTAssertEqual(obj?.saleEnabled, true)
        XCTAssertEqual(obj?.venue?.name, "venueName")
    }
}
