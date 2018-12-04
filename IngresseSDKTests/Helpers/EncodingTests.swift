//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class EncodingTests: XCTestCase {

    func testNotStringValue() {
        // Given
        var dict = [String: Any]()
        dict["string"] = "testString"
        dict["bool"] = true
        dict["int"] = 10
        dict["double"] = 99.9

        // When
        let string = dict.stringFromHttpParameters()
        let expected = string.contains("double=99.9")
            && string.contains("bool=true")
            && string.contains("string=testString")
            && string.contains("int=10")

        // Then
        XCTAssert(expected)
    }

    func testTrim() {
        // Given
        let string = " Test string with whitespaces "
        let expected = "Test string with whitespaces"

        // When
        let generated = string.trim()

        // Then
        XCTAssertEqual(generated, expected)
    }
}
