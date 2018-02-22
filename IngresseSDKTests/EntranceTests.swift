//
//  EntranceServiceTests.swift
//  IngresseSDKTests
//
//  Created by Rubens Gondek on 6/8/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import XCTest
import IngresseSDK

class EntranceTests: XCTestCase {

    var restClient : MockClient!
    var client : IngresseClient!
    var service : IngresseService!

    override func setUp() {
        super.setUp()

        restClient = MockClient()
        client = IngresseClient(publicKey: "1234", privateKey: "2345", restClient: restClient)
        service = IngresseService(client: client)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetGuestList() {
        let guestExpectation = expectation(description: "guestListCallback")

        var guestListSuccessResponse = [String:Any]()
        guestListSuccessResponse["paginationInfo"] =
            ["currentPage": 1,
             "lastPage": 1,
             "totalResults": 0,
             "pageSize": "10"]
        guestListSuccessResponse["data"] = []

        restClient.response = guestListSuccessResponse

        let delegate = SpyGuestListSyncDelegate()
        delegate.asyncExpectation = guestExpectation

        service.entrance.getGuestListOfEvent("12345", sessionId: "23456", userToken: "12345-abcdefghijklmnopqrstuvxyz", page: 1, delegate: delegate)

        waitForExpectations(timeout: 1) { (error:Error?) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout error: \(error)")
            }

            XCTAssert(delegate.calledDidSync)

            guard let result = delegate.guestListSyncResult else {
                XCTFail("no result")
                return
            }

            XCTAssertEqual([], result)
        }
    }

    func testGetGuestListFail() {
        let guestExpectation = expectation(description: "guestListCallback")

        var guestListSuccessResponse = [String:Any]()
        guestListSuccessResponse["data"] = nil

        restClient.response = guestListSuccessResponse

        let delegate = SpyGuestListSyncDelegate()
        delegate.asyncExpectation = guestExpectation

        service.entrance.getGuestListOfEvent("12345", sessionId: "23456", userToken: "12345-abcdefghijklmnopqrstuvxyz", page: 1, delegate: delegate)

        waitForExpectations(timeout: 1) { (error:Error?) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout error: \(error)")
            }

            XCTAssert(delegate.calledDidFail)

            XCTAssertNil(delegate.guestListSyncResult)
        }
    }

}
