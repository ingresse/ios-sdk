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

    func testApplyJSON() {
        var json = ["description": "test string"]
        json["name"] = "test name"

        let obj = TransferTicket()
        obj.applyJSON(json)

        XCTAssertEqual(obj.desc, "test string")
        XCTAssertEqual(obj.name, "test name")
    }

}
