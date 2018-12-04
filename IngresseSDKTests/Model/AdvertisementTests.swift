//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class AdvertisementTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String: Any]()
        json["cover"] = [
            "image": "coverImage",
            "url": "coverUrl"
        ]
        json["background"] = [
            "image": "bgImage"
        ]

        // When
        let obj = JSONDecoder().decodeDict(of: Advertisement.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.cover?.image, "coverImage")
        XCTAssertEqual(obj?.cover?.url, "coverUrl")
        XCTAssertEqual(obj?.background?.image, "bgImage")
    }
}
