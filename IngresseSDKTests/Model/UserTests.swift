//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class UserTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String: Any]()
        json["id"] = 1
        json["name"] = "name"
        json["email"] = "email"
        json["type"] = "type"
        json["username"] = "username"
        json["phone"] = "phone"
        json["cellphone"] = "cellphone"
        json["pictures"] = [:]
        json["social"] = [
            [
                "network": "facebook",
                "id": "facebookId"
            ], [
                "network": "twitter",
                "id": "twitterId"
            ]
        ]

        // When
        let obj = JSONDecoder().decodeDict(of: User.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, 1)
        XCTAssertEqual(obj?.name, "name")
        XCTAssertEqual(obj?.email, "email")
        XCTAssertEqual(obj?.type, "type")
        XCTAssertEqual(obj?.username, "username")
        XCTAssertEqual(obj?.phone, "phone")
        XCTAssertEqual(obj?.cellphone, "cellphone")
        XCTAssertEqual(obj?.pictures, [:])

        let social = obj!.social
        XCTAssertEqual(social[0].network, "facebook")
        XCTAssertEqual(social[1].network, "twitter")
        XCTAssertEqual(social[0].id, "facebookId")
        XCTAssertEqual(social[1].id, "twitterId")
    }
    
    func testEmptyInit() {
        // When
        let obj = User()

        // Then
        XCTAssertEqual(obj.id, 0)
        XCTAssertEqual(obj.name, "")
        XCTAssertEqual(obj.email, "")
        XCTAssertEqual(obj.type, "")
        XCTAssertEqual(obj.username, "")
        XCTAssertEqual(obj.phone, "")
        XCTAssertEqual(obj.cellphone, "")
        XCTAssertEqual(obj.pictures, [:])
        XCTAssertEqual(obj.social, [])
    }
}
