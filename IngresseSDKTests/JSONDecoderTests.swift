//
//  JSONDecoderTests.swift
//  IngresseSDKTests
//
//  Created by Rubens Gondek on 3/7/18.
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
        let dict: [String:Any] = ["id": 111]

        let obj = JSONDecoder().decodeDict(of: TestObj.self, from: dict)

        XCTAssertNotNil(obj)
    }
}
