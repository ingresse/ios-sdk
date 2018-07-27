//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class UserTicketTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String:Any]()
        json["receivedFrom"] = ["transferId":1]
        json["transferedTo"] = ["transferId":2]
        json["currentHolder"] = ["transferId":3]
        json["eventVenue"] = ["id":4]
        json["sessions"] = ["data":[["id":5], ["id":6], ["id":7]]]
        json["description"] = "test string"
        json["checked"] = true

        // When
        let obj = JSONDecoder().decodeDict(of: UserTicket.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.receivedFrom!.transferId, 1)
        XCTAssertEqual(obj?.transferedTo?.transferId, 2)
        XCTAssertEqual(obj?.currentHolder?.transferId, 3)
        XCTAssertEqual(obj?.eventVenue?.id, 4)
        XCTAssertEqual(obj?.sessions[0].id, 5)
        XCTAssertEqual(obj?.sessions[1].id, 6)
        XCTAssertEqual(obj?.sessions[2].id, 7)
        XCTAssertEqual(obj?.desc, "test string")
        XCTAssertEqual(obj?.checked, true)
    }
}
