//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TransactionServiceTests: XCTestCase {
    var restClient: MockClient!
    var client: IngresseClient!
    var service: TransactionService!
    
    override func setUp() {
        super.setUp()

        restClient = MockClient()
        client = IngresseClient(apiKey: "1234", userAgent: "", restClient: restClient)
        service = IngresseService(client: client).transaction
    }
    
    // MARK: - Transaction Details
    func testGetTransactionDetails() {
        // Given
        let asyncExpectation = expectation(description: "transactionDetails")

        var response = [String: Any]()
        response["data"] = []

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: TransactionData?

        // When
        service.getTransactionDetails("transactionId", userToken: "1234-token", onSuccess: { (data) in
            success = true
            result = data
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }
    
    func testGetFriendsFail() {
        // Given
        let asyncExpectation = expectation(description: "transactionDetails")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getTransactionDetails("transactionId", userToken: "1234-token", onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    func testCreateTransaction() {
        // Given
        let asyncExpectation = expectation(description: "createTransaction")

        var response = [String: Any]()
        response["data"] = ["transactionId": "transactionId"]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: String!

        let sessionTickets = [ShopTicket(id: 0,
                                         name: "name",
                                         fullDescription: "fullDescription",
                                         guestTypeId: 0,
                                         status: "status",
                                         typeName: "typeName",
                                         price: 0.0,
                                         tax: 0.0,
                                         hidden: false,
                                         quantity: 1,
                                         maximum: 1,
                                         minimum: 1)]

        // When
        service.createTransaction(
            userId: "userId",
            userToken: "1234-token",
            eventId: "eventId",
            passkey: "passkey",
            sessionTickets: sessionTickets,
            onSuccess: { (transactionId) in
                success = true
                result = transactionId
                asyncExpectation.fulfill()
        }, onError: { (error) in })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }

    func testCreateTransactionWrongData() {
        // Given
        let asyncExpectation = expectation(description: "createTransaction")

        var response = [String: Any]()
        response["data"] = []

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        let sessionTickets = [ShopTicket(id: 0,
                                         name: "name",
                                         fullDescription: "fullDescription",
                                         guestTypeId: 0,
                                         status: "status",
                                         typeName: "typeName",
                                         price: 0.0,
                                         tax: 0.0,
                                         hidden: false,
                                         quantity: 1,
                                         maximum: 1,
                                         minimum: 1)]

        // When
        service.createTransaction(
            userId: "userId",
            userToken: "1234-token",
            eventId: "eventId",
            passkey: "passkey",
            sessionTickets: sessionTickets,
            onSuccess: { (transactionId) in },
            onError: { (error) in
                success = false
                apiError = error
                asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(apiError?.code, defaultError.code)
            XCTAssertEqual(apiError?.message, defaultError.message)
        }
    }

    func testCreateTransactionFail() {
        // Given
        let asyncExpectation = expectation(description: "createTransaction")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.createTransaction(
            userId: "userId",
            userToken: "1234-token",
            eventId: "eventId",
            passkey: "passkey",
            sessionTickets: [ShopTicket](),
            onSuccess: { (transactionId) in },
            onError: { (error) in
                success = false
                apiError = error
                asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    // MARK: - Checkin Status
    func testGetCheckinStatus() {
        // Given
        let asyncExpectation = expectation(description: "checkinStatus")

        var response = [String: Any]()
        response["data"] = []

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: [CheckinSession]?

        // When
        service.getCheckinStatus("123456", userToken: "1234-token", onSuccess: { (data) in
            success = true
            result = data
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }

    func testGetCheckinStatusWrongData() {
        // Given
        let asyncExpectation = expectation(description: "checkinStatus")

        var response = [String: Any]()
        response["advertisement"] = nil

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.getCheckinStatus("123456", userToken: "1234-token", onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(apiError?.code, defaultError.code)
            XCTAssertEqual(apiError?.message, defaultError.message)
        }
    }

    func testGetCheckinStatusFail() {
        // Given
        let asyncExpectation = expectation(description: "checkinStatus")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getCheckinStatus("123456", userToken: "1234-token", onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }
}
