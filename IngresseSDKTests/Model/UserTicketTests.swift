//
//  UserTicketTests.swift
//  IngresseSDKTests
//
//  Created by Rubens Gondek on 2/16/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class UserTicketTests: XCTestCase {
    
    func testApplyJSON() {
        var json = [String:Any]()
        json["receivedFrom"] = ["transferId":1]
        json["transferedTo"] = ["transferId":2]
        json["currentHolder"] = ["transferId":3]
        json["eventVenue"] = ["id":4]
        json["sessions"] = [["id":5], ["id":6], ["id":7]]
        json["description"] = "test string"
        json["checked"] = true

        let obj = UserTicket()
        obj.applyJSON(json)

        XCTAssertEqual(obj.receivedFrom!.transferId, 1)
        XCTAssertEqual(obj.transferedTo?.transferId, 2)
        XCTAssertEqual(obj.currentHolder?.transferId, 3)
        XCTAssertEqual(obj.eventVenue.id, 4)
        XCTAssertEqual(obj.sessions[0].id, 5)
        XCTAssertEqual(obj.sessions[1].id, 6)
        XCTAssertEqual(obj.sessions[2].id, 7)
        XCTAssertEqual(obj.desc, "test string")
        XCTAssertEqual(obj.checked, true)
    }

    func testApplyJSONWrongValues() {
        var json = [String:Any]()
        json["receivedFrom"] = "test string"
        json["eventVenue"] = 4

        let obj = UserTicket()
        obj.applyJSON(json)

        XCTAssertNil(obj.receivedFrom)
        XCTAssertEqual(obj.eventVenue.id, 0)
    }
    
}
