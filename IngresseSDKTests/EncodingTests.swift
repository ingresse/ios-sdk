//
//  EncodingTests.swift
//  IngresseSDKTests
//
//  Created by Rubens Gondek on 3/7/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class EncodingTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testNotStringValue() {
        var dict = [String:Any]()
        dict["string"] = "testString"
        dict["bool"] = true
        dict["int"] = 10
        dict["double"] = 99.9

        let string = dict.stringFromHttpParameters()
        let expected = "int=10&double=99.9&bool=true&string=testString"

        XCTAssertEqual(string, expected)
    }

    func testTrim() {
        let string = " Test string with whitespaces "
        let expected = "Test string with whitespaces"

        let generated = string.trim()

        XCTAssertEqual(generated, expected)
    }
}
