//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class CompanyTests: XCTestCase {

    func testDecode() {
        // Given
        var json = [String: Any]()
        json["id"] = 1
        json["name"] = "company"

        // When
        let obj = JSONDecoder().decodeDict(of: Company.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, 1)
        XCTAssertEqual(obj?.name, "company")
        XCTAssertNil(obj?.logo)
    }
}
