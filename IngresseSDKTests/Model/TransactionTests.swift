//
//  TransactionTests.swift
//  IngresseSDKTests
//
//  Created by Rubens Gondek on 2/16/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TransactionTests: XCTestCase {

    func testDecode() {
        var json = [String:Any]()
        json["event"] = ["id":"1"]
        json["session"] = ["id":"2"]
        json["customer"] = ["id":3]
        json["refund"] = ["operatorId":"4"]
        json["creditCard"] = ["firstDigits":"5"]
        json["id"] = "1234"

        guard let obj = JSONDecoder().decodeDict(of: Transaction.self, from: json) else {
            XCTFail("Could not convert object")
            return
        }

        XCTAssertEqual(obj.event?.id, "1")
        XCTAssertEqual(obj.session?.id, "2")
        XCTAssertEqual(obj.customer?.id, 3)
        XCTAssertEqual(obj.refund?.operatorId, "4")
        XCTAssertEqual(obj.creditCard?.firstDigits, "5")
        XCTAssertEqual(obj.id, "1234")
    }
}
