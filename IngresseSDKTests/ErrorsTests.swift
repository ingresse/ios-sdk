//
//  IngresseErrorsTests.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/16/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class ErrorsTests: XCTestCase {

    var errors: SDKErrors?
    var errorsDict: [String:String]!

    override func setUp() {
        super.setUp()

        errors = SDKErrors()

        errorsDict = SDKErrors.shared.errorDict
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDefaultError() {
        let generated = errors?.getErrorMessage(code: 0)
        let expected = errorsDict["default_no_code"]!

        XCTAssertEqual(generated, expected)
    }

    func testDefaultErrorWithCode() {
        let generated = errors?.getErrorMessage(code: 99999)
        let expected = String(format: errorsDict["default_message"]!, 99999)

        XCTAssertEqual(generated, expected)
    }

}
