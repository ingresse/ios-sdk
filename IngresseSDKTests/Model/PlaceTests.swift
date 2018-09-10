//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class PlaceTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String:Any]()
        json["city"] = "city"
        json["country"] = "country"
        json["externalId"] = "externalId"
        json["id"] = 1
        json["location"] = ["lat": 10.0, "long": 20.0]
        json["name"] = "name"
        json["origin"] = "origin"
        json["state"] = "state"
        json["street"] = "street"
        json["zip"] = "zip"

        // When
        let obj = JSONDecoder().decodeDict(of: Place.self, from: json)

        // Then
        XCTAssertEqual(obj?.city, "city")
        XCTAssertEqual(obj?.country, "country")
        XCTAssertEqual(obj?.externalId, "externalId")
        XCTAssertEqual(obj?.name, "name")
        XCTAssertEqual(obj?.origin, "origin")
        XCTAssertEqual(obj?.state, "state")
        XCTAssertEqual(obj?.street, "street")
        XCTAssertEqual(obj?.zip, "zip")
        XCTAssertEqual(obj?.location?.lat, 10.0)
        XCTAssertEqual(obj?.location?.long, 20.0)
    }
}
