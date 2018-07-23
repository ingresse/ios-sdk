//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class NewEventTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String: Any]()
        json["createdAt"] = "createdAt"
        json["description"] = "description"
        json["companyId"] = 1
        json["id"] = 2
        json["producerId"] = 3
        json["slug"] = "slug"
        json["status"] = ["id": 4, "name": "status"]
        json["title"] = "title"
        json["updatedAt"] = "updatedAt"
        let source = ["_source": json]

        // When
        let obj = JSONDecoder().decodeDict(of: NewEvent.self, from: source)

        // Then
        XCTAssertEqual(obj?.createdAt, "createdAt")
        XCTAssertEqual(obj?.desc, "description")
        XCTAssertEqual(obj?.companyId, 1)
        XCTAssertEqual(obj?.id, 2)
        XCTAssertEqual(obj?.producerId, 3)
        XCTAssertEqual(obj?.slug, "slug")
        XCTAssertEqual(obj?.title, "title")
        XCTAssertEqual(obj?.status?.id, 4)
        XCTAssertEqual(obj?.status?.name, "status")
        XCTAssertEqual(obj?.updatedAt, "updatedAt")
    }
}
