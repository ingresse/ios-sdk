//
//  Copyright © 2017 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class EntranceServiceTests: XCTestCase {

    var restClient: MockClient!
    var client: IngresseClient!
    var service: EntranceService!

    override func setUp() {
        super.setUp()

        restClient = MockClient()
        client = IngresseClient(apiKey: "1234", restClient: restClient)
        service = IngresseService(client: client).entrance
    }

    // MARK: - Guest List
    func testGetGuestList() {
        // Given
        let guestExpectation = expectation(description: "guestListCallback")

        var guestListSuccessResponse = [String:Any]()
        guestListSuccessResponse["paginationInfo"] =
            ["currentPage": 1,
             "lastPage": 1,
             "totalResults": 0,
             "pageSize": 10]
        guestListSuccessResponse["data"] = []

        restClient.response = guestListSuccessResponse
        restClient.shouldFail = false

        let delegate = GuestListSyncDelegateSpy()
        delegate.asyncExpectation = guestExpectation

        // When
        service.getGuestListOfEvent("12345", sessionId: "23456", from: 9999, userToken: "12345-abcdefghijklmnopqrstuvxyz", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didSyncGuestsPageCalled)
            XCTAssertEqual(delegate.guestListSyncResult, [])
        }
    }

    func testGetGuestListWrongData() {
        // Given
        let guestExpectation = expectation(description: "guestListCallback")

        var guestListSuccessResponse = [String:Any]()
        guestListSuccessResponse["data"] = nil

        restClient.response = guestListSuccessResponse
        restClient.shouldFail = false

        let delegate = GuestListSyncDelegateSpy()
        delegate.asyncExpectation = guestExpectation

        // When
        service.getGuestListOfEvent("12345", sessionId: "23456", userToken: "12345-abcdefghijklmnopqrstuvxyz", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didFailSyncGuestListCalled)
            XCTAssertNil(delegate.guestListSyncResult)
        }
    }

    func testGetGuestListFail() {
        // Given
        let guestExpectation = expectation(description: "guestListCallback")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        let delegate = GuestListSyncDelegateSpy()
        delegate.asyncExpectation = guestExpectation

        // When
        service.getGuestListOfEvent("12345", sessionId: "23456", userToken: "12345-abcdefghijklmnopqrstuvxyz", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didFailSyncGuestListCalled)
            XCTAssertNil(delegate.guestListSyncResult)
            let apiError = delegate.syncFailError
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    // MARK: - Checkin Tickets
    func testCheckinTickets() {
        // Given
        let checkinExpectation = expectation(description: "checkinTickets")

        var response = [String:Any]()
        response["data"] = []

        restClient.response = response
        restClient.shouldFail = false

        let delegate = CheckinSyncDelegateSpy()
        delegate.asyncExpectation = checkinExpectation

        // When
        service.checkinTickets(["000", "111", "333"], ticketStatus: ["0", "0", "0"], ticketTimestamps: ["999", "999", "999"], eventId: "1234", sessionId: "2345", userToken: "12345-token", delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didCheckinTicketsCalled)
            XCTAssertEqual(delegate.checkinResult, [])
        }
    }

    func testCheckinTicketsWrongData() {
        // Given
        let checkinExpectation = expectation(description: "checkinTickets")

        var response = [String:Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        let delegate = CheckinSyncDelegateSpy()
        delegate.asyncExpectation = checkinExpectation

        // When
        service.checkinTickets(["000", "111", "333"], ticketStatus: ["0", "0", "0"], ticketTimestamps: ["999", "999", "999"], eventId: "1234", sessionId: "2345", userToken: "12345-token", delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didFailCheckinCalled)
            XCTAssertNil(delegate.checkinResult)
        }
    }

    func testCheckinTicketsFail() {
        // Given
        let checkinExpectation = expectation(description: "checkinTickets")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        let delegate = CheckinSyncDelegateSpy()
        delegate.asyncExpectation = checkinExpectation

        // When
        service.checkinTickets(["000", "111", "333"], ticketStatus: ["0", "0", "0"], ticketTimestamps: ["999", "999", "999"], eventId: "1234", sessionId: "2345", userToken: "12345-token", delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didFailCheckinCalled)
            XCTAssertNil(delegate.checkinResult)
            let apiError = delegate.syncFailError
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    // MARK: - Validation Info
    func testGetValidationInfo() {
        // Given
        let infoExpectation = expectation(description: "validationInfo")

        var response = [String:Any]()
        response["data"] = [
            ["code": "000", "status": 3, "lastUpdate": 999, "checked": 1, "owner": nil, "lastCheckin" : nil],
            ["code": "111", "status": 4, "lastUpdate": 99, "checked": 0, "owner": nil, "lastCheckin" : nil]
        ]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: CheckinTicket?

        // When
        service.getValidationInfoOfTicket(code: "000", eventId: "1234", sessionId: "2345", userToken: "12345-token", onSuccess: { (ticket) in
            success = true
            result = ticket
            infoExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.checked, 1)
            XCTAssertEqual(result?.code, "000")
            XCTAssertEqual(result?.lastUpdate, 999)
            XCTAssertEqual(result?.status, 3)
            XCTAssertEqual(result?.owner, nil)
            XCTAssertEqual(result?.lastCheckin, nil)
        }
    }

    func testGetValidationInfoWrongData() {
        // Given
        let infoExpectation = expectation(description: "validationInfo")

        var response = [String:Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.getValidationInfoOfTicket(code: "000", eventId: "1234", sessionId: "2345", userToken: "12345-token", onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            infoExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(apiError?.code, defaultError.code)
            XCTAssertEqual(apiError?.message, defaultError.message)
        }
    }

    func testGetValidationInfoFail() {
        // Given
        let infoExpectation = expectation(description: "validationInfo")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getValidationInfoOfTicket(code: "000", eventId: "1234", sessionId: "2345", userToken: "12345-token", onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            infoExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    // MARK: - Transfer History
    func testGetTransferHistory() {
        // Given
        let transferHistoryExpectation = expectation(description: "transferHistory")

        var response = [String:Any]()
        response["data"] = []

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: [TransferHistoryItem]?

        // When
        service.getTransferHistory(ticketId: "123", userToken: "12345-token", onSuccess: { (items) in
            success = true
            result = items
            transferHistoryExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }

    func testGetTransferHistoryWrongData() {
        // Given
        let transferHistoryExpectation = expectation(description: "transferHistory")

        var response = [String:Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.getTransferHistory(ticketId: "123", userToken: "12345-token", onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            transferHistoryExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(apiError?.code, defaultError.code)
            XCTAssertEqual(apiError?.message, defaultError.message)
        }
    }

    func testGetTransferHistoryFail() {
        // Given
        let transferHistoryExpectation = expectation(description: "transferHistory")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getTransferHistory(ticketId: "123", userToken: "12345-token", onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            transferHistoryExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }
}
