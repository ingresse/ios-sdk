//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class AddressTests: XCTestCase {

    func testDecode() {
        // Given
        var json = [String: Any]()
        json["street"] = "street"
        json["district"] = "district"
        json["state"] = "state"
        json["city"] = "city"

        // When
        let obj = JSONDecoder().decodeDict(of: Address.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.street, "street")
        XCTAssertEqual(obj?.district, "district")
        XCTAssertEqual(obj?.state, "state")
        XCTAssertEqual(obj?.city, "city")
    }
}
