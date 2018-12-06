//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class PendingTransferTests: XCTestCase {
    func testDecode() {
        // Given
        var json = [String: Any]()
        json["id"] = 1
        json["event"] = ["id": 2]
        json["venue"] = ["id": 3]
        json["session"] = ["id": 4]
        json["ticket"] = ["id": 5]
        json["receivedFrom"] = ["transferId": 6]
        json["sessions"] = ["data": [["id": 11], ["id": 12], ["id": 13]]]

        // When
        let obj = JSONDecoder().decodeDict(of: PendingTransfer.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, 1)
        XCTAssertEqual(obj?.event?.id, 2)
        XCTAssertEqual(obj?.venue?.id, 3)
        XCTAssertEqual(obj?.session?.id, 4)
        XCTAssertEqual(obj?.ticket?.id, 5)
        XCTAssertEqual(obj?.receivedFrom?.transferId, 6)
        XCTAssertEqual(obj?.sessions.count, 3)
        XCTAssertEqual(obj?.sessions[0].id, 11)
        XCTAssertEqual(obj?.sessions[1].id, 12)
        XCTAssertEqual(obj?.sessions[2].id, 13)
    }
}
