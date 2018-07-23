//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class EventTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String:Any]()
        json["id"] = 1
        json["title"] = "eventTitle"
        json["link"] = "eventLink"
        json["type"] = "eventType"
        json["poster"] = "eventPoster"
        json["status"] = "eventStatus"
        json["rsvpTotal"] = 100
        json["saleEnabled"] = true
        json["description"] = "eventDescription"

        // When
        let obj = JSONDecoder().decodeDict(of: Event.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, 1)
        XCTAssertEqual(obj?.title, "eventTitle")
        XCTAssertEqual(obj?.link, "eventLink")
        XCTAssertEqual(obj?.type, "eventType")
        XCTAssertEqual(obj?.poster, "eventPoster")
        XCTAssertEqual(obj?.status, "eventStatus")
        XCTAssertEqual(obj?.rsvpTotal, 100)
        XCTAssertEqual(obj?.saleEnabled, true)
        XCTAssertEqual(obj?.eventDescription, "eventDescription")
    }
}
