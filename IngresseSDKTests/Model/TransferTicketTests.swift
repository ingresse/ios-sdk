//
//  TransferTicketTests.swift
//  IngresseSDKTests
//
//  Created by Rubens Gondek on 2/16/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TransferTicketTests: XCTestCase {

    func testDecode() {
        var json = ["description": "test string"]
        json["name"] = "test name"

        guard let obj = JSONDecoder().decodeDict(of: TransferTicket.self, from: json) else {
            XCTFail("Could not convert object")
            return
        }

        XCTAssertEqual(obj.desc, "test string")
        XCTAssertEqual(obj.name, "test name")
    }

}
