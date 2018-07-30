//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class VenueTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String:Any]()
        json["id"] = 1
        json["city"] = "city"
        json["complement"] = "complement"
        json["country"] = "country"
        json["crossStreet"] = "crossStreet"
        json["name"] = "name"
        json["state"] = "state"
        json["street"] = "street"
        json["zipCode"] = "zipCode"
        json["hidden"] = true
        json["location"] = [-40.0, 20.0]

        // When
        let obj = JSONDecoder().decodeDict(of: Venue.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, 1)
        XCTAssertEqual(obj?.city, "city")
        XCTAssertEqual(obj?.complement, "complement")
        XCTAssertEqual(obj?.country, "country")
        XCTAssertEqual(obj?.crossStreet, "crossStreet")
        XCTAssertEqual(obj?.name, "name")
        XCTAssertEqual(obj?.state, "state")
        XCTAssertEqual(obj?.street, "street")
        XCTAssertEqual(obj?.zipCode, "zipCode")
        XCTAssertEqual(obj?.hidden, true)
        XCTAssertEqual(obj?.location, [-40.0, 20.0])
        XCTAssertEqual(obj?.latitude, 20.0)
        XCTAssertEqual(obj?.longitude, -40.0)
    }
    
    func testLatLong() {
        // Given
        var json = [String:Any]()
        json["latitude"] = 10.0
        json["longitude"] = 20.0

        // When
        let obj = JSONDecoder().decodeDict(of: Venue.self, from: json)

        // Then
        XCTAssertEqual(obj?.latitude, 10.0)
        XCTAssertEqual(obj?.longitude, 20.0)
    }
}
