//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class PosterTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String:Any]()
        json["large"] = "large"
        json["medium"] = "medium"
        json["small"] = "small"
        json["xLarge"] = "xLarge"

        // When
        let obj = JSONDecoder().decodeDict(of: Poster.self, from: json)

        // Then
        XCTAssertEqual(obj?.large, "large")
        XCTAssertEqual(obj?.medium, "medium")
        XCTAssertEqual(obj?.small, "small")
        XCTAssertEqual(obj?.xLarge, "xLarge")
    }
}
