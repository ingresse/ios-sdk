//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class WalletItemTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String:Any]()
        json["id"] = 1
        json["ownerId"] = 2
        json["title"] = "title"
        json["link"] = "link"
        json["type"] = "type"
        json["poster"] = "poster"
        json["tickets"] = 99
        json["transfered"] = 88
        json["description"] = "description"
        json["venue"] = ["id":1]
        json["sessions"] = ["data":[["id":2], ["id":3], ["id":4]]]
        json["customTickets"] = [["name":"test1"], ["name":"test2"], ["name":"test3"]]

        // When
        let obj = JSONDecoder().decodeDict(of: WalletItem.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, 1)
        XCTAssertEqual(obj?.ownerId, 2)
        XCTAssertEqual(obj?.title, "title")
        XCTAssertEqual(obj?.link, "link")
        XCTAssertEqual(obj?.type, "type")
        XCTAssertEqual(obj?.poster, "poster")
        XCTAssertEqual(obj?.tickets, 99)
        XCTAssertEqual(obj?.transfered, 88)
        XCTAssertEqual(obj?.venue?.id, 1)
        XCTAssertEqual(obj?.sessions[0].id, 2)
        XCTAssertEqual(obj?.sessions[1].id, 3)
        XCTAssertEqual(obj?.sessions[2].id, 4)
        XCTAssertEqual(obj?.customTickets[0].name, "test1")
        XCTAssertEqual(obj?.customTickets[1].name, "test2")
        XCTAssertEqual(obj?.customTickets[2].name, "test3")
        XCTAssertEqual(obj?.eventDescription, "description")
    }
}
