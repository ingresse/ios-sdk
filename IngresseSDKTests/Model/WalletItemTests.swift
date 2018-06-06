//
//  WalletItemTests.swift
//  IngresseSDKTests
//
//  Created by Rubens Gondek on 2/16/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class WalletItemTests: XCTestCase {
    
    func testDecode() {
        var json = [String:Any]()
        json["venue"] = ["id":1]
        json["sessions"] = [["id":2], ["id":3], ["id":4]]
        json["sessionList"] = [["id":5], ["id":6], ["id":7]]
        json["customTickets"] = [["name":"test1"], ["name":"test2"], ["name":"test3"]]
        json["description"] = "test string"
        json["id"] = 1234

        guard let obj = JSONDecoder().decodeDict(of: WalletItem.self, from: json) else {
            XCTFail("Could not convert object")
            return
        }

        XCTAssertEqual(obj.venue?.id, 1)
        XCTAssertEqual(obj.sessions[0].id, 2)
        XCTAssertEqual(obj.sessions[1].id, 3)
        XCTAssertEqual(obj.sessions[2].id, 4)
        XCTAssertEqual(obj.sessionList[0].id, 5)
        XCTAssertEqual(obj.sessionList[1].id, 6)
        XCTAssertEqual(obj.sessionList[2].id, 7)
        XCTAssertEqual(obj.customTickets[0].name, "test1")
        XCTAssertEqual(obj.customTickets[1].name, "test2")
        XCTAssertEqual(obj.customTickets[2].name, "test3")
        XCTAssertEqual(obj.eventDescription, "test string")
        XCTAssertEqual(obj.id, 1234)
    }

    func testDecodeWrongValues() {
        var json = [String:Any]()
        json["venue"] = 1234

        let obj = JSONDecoder().decodeDict(of: WalletItem.self, from: json)

        XCTAssertNil(obj)
    }
    
}
