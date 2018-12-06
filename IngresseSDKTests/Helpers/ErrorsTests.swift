//
//  Copyright © 2017 Gondek. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class ErrorsTests: XCTestCase {

    var errors: SDKErrors?
    var errorsDict: [String: String]!

    override func setUp() {
        super.setUp()

        errors = SDKErrors()

        errorsDict = SDKErrors.shared.errorDict
    }

    func testDefaultError() {
        // When
        let generated = errors?.getErrorMessage(code: 0)
        let expected = errorsDict["default_no_code"]!

        // Then
        XCTAssertEqual(generated, expected)
    }

    func testDefaultErrorWithCode() {
        // When
        let generated = errors?.getErrorMessage(code: 99999)
        let expected = String(format: errorsDict["default_message"]!, 99999)

        // Then
        XCTAssertEqual(generated, expected)
    }

    func testErrorBuilder() {
        // When
        let error = APIError.Builder()
            .setCode(0)
            .setTitle("Test Title")
            .setMessage("Test Message")
            .setResponse(["string": "response", "bool": true, "int": 99])
            .setError("Test Error")
            .setCategory("Test Category")
            .build()

        // Then
        XCTAssertEqual(error.code, 0)
        XCTAssertEqual(error.title, "Test Title")
        XCTAssertEqual(error.error, "Test Error")
        XCTAssertEqual(error.message, "Test Message")
        XCTAssertEqual(error.category, "Test Category")
        XCTAssertEqual(error.response["int"] as? Int, 99)
        XCTAssertEqual(error.response["bool"] as? Bool, true)
        XCTAssertEqual(error.response["string"] as? String, "response")
    }
}
