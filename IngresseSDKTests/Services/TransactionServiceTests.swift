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
}

// MARK: - Transaction Details
extension TransactionServiceTests {
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
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }
    
    func testGetTransactionDetailsFail() {
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
        waitForExpectations(timeout: 1) { (_) in
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
        let card = ["CartaoCredito": ["paymentType": "credito"]]
        response["data"] = [
            "transactionId": "transactionId",
            "availablePaymentMethods": card
        ]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: Response.Shop.Transaction?

        var ticket = PaymentTicket()
        ticket.guestTypeId = "0"
        ticket.quantity = 1
        ticket.holder = []

        let sessionTickets = [ticket]

        var request = Request.Shop.Create()
        request.userId = "userId"
        request.eventId = "eventId"
        request.passkey = "passkey"
        request.tickets = sessionTickets

        // When
        service.createTransaction(request: request, userToken: "1234-token", onSuccess: { (transaction) in
            success = true
            result = transaction
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (_) in
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

        var ticket = PaymentTicket()
        ticket.guestTypeId = "0"
        ticket.quantity = 1
        ticket.holder = []

        let sessionTickets = [ticket]

        var request = Request.Shop.Create()
        request.userId = "userId"
        request.eventId = "eventId"
        request.passkey = "passkey"
        request.tickets = sessionTickets

        // When
        service.createTransaction(request: request, userToken: "1234-token", onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (_) in
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

        var request = Request.Shop.Create()
        request.userId = "userId"
        request.eventId = "eventId"
        request.passkey = "passkey"
        request.tickets = []

        // When
        service.createTransaction(request: request, userToken: "1234-token", onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }
}

// MARK: - Checkin Status
extension TransactionServiceTests {
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
        waitForExpectations(timeout: 1) { (_) in
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
        waitForExpectations(timeout: 1) { (_) in
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
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }
}

// MARK: - Cancel Transaction
extension TransactionServiceTests {
    func testCancelTransaction() {
        // Given
        let asyncExpectation = expectation(description: "cancelTransaction")

        var response = [String: Any]()
        response["data"] = []

        restClient.response = response
        restClient.shouldFail = false

        var success = false

        // When
        service.cancelTransaction("transactionId", userToken: "1234-token", onSuccess: {
            success = true
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(success)
        }
    }

    func testCancelTransactionFail() {
        // Given
        let asyncExpectation = expectation(description: "cancelTransaction")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.cancelTransaction("transactionId", userToken: "1234-token", onSuccess: {}, onError: { (error) in
            success = false
            apiError = error
            asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }
}
