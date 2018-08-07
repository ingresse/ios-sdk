//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class PlannerTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String:Any]()
        json["id"] = 1
        json["name"] = "name"
        json["email"] = "email"
        json["phone"] = "phone"
        json["link"] = "link"
        json["logo"] = "logo"

        // When
        let obj = JSONDecoder().decodeDict(of: Planner.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, 1)
        XCTAssertEqual(obj?.name, "name")
        XCTAssertEqual(obj?.email, "email")
        XCTAssertEqual(obj?.phone, "phone")
        XCTAssertEqual(obj?.link, "link")
        XCTAssertEqual(obj?.logo, "logo")
    }
}
