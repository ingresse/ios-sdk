//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class JSONDecoderTests: XCTestCase {

    struct TestObj: Codable {
        var id = 0
        var name: String? = ""
    }

    func testDecodeDict() {
        // Given
        let dict: [String:Any] = ["id": 111]

        // When
        let obj = JSONDecoder().decodeDict(of: TestObj.self, from: dict)

        // Then
        XCTAssertNotNil(obj)
    }
}
