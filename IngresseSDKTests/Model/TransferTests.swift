//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TransferTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String: Any]()
        json["transferId"] = 1
        json["userId"] = 2
        json["status"] = "status"
        json["email"] = "email"
        json["name"] = "name"
        json["type"] = "type"
        json["picture"] = "picture"
        json["socialId"] = []
        json["history"] = []

        // When
        let obj = JSONDecoder().decodeDict(of: Transfer.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.transferId, 1)
        XCTAssertEqual(obj?.userId, 2)
        XCTAssertEqual(obj?.email, "email")
        XCTAssertEqual(obj?.type, "type")
        XCTAssertEqual(obj?.name, "name")
        XCTAssertEqual(obj?.status, "status")
        XCTAssertEqual(obj?.picture, "picture")
        XCTAssertEqual(obj?.socialId, [])
        XCTAssertEqual(obj?.history, [])
    }
    
    func testStatusHistory() {
        // Given
        var json = [String: Any]()
        json["history"] = [
            [
                "status": "pending",
                "creationDate": "createdAt"
            ], [
                "status": "accepted",
                "creationDate": "acceptedAt"
            ]
        ]

        // When
        let obj = JSONDecoder().decodeDict(of: Transfer.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.created, "createdAt")
        XCTAssertEqual(obj?.accepted, "acceptedAt")
    }
    
    func testStatusHistoryWithoutStatus() {
        // Given
        var json = [String: Any]()
        json["history"] = []

        // When
        let obj = JSONDecoder().decodeDict(of: Transfer.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.created, "")
        XCTAssertEqual(obj?.accepted, "")
    }

    func testSocialId() {
        // Given
        var json = [String: Any]()
        json["socialId"] = [
            [
                "network": "facebook",
                "id": "facebookId"
            ], [
                "network": "twitter",
                "id": "twitterId"
            ]
        ]

        // When
        let obj = JSONDecoder().decodeDict(of: Transfer.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        let socialId = obj?.socialIdDict
        XCTAssertEqual(socialId!["twitter"], "twitterId")
        XCTAssertEqual(socialId!["facebook"], "facebookId")
    }
}
