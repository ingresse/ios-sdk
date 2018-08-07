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
        client = IngresseClient(publicKey: "1234", privateKey: "2345", restClient: restClient)
        service = IngresseService(client: client).transaction
    }
    
    // MARK: - Transaction Details
    func testGetTransactionDetails() {
        // Given
        let asyncExpectation = expectation(description: "transactionDetails")

        var response = [String:Any]()
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
        waitForExpectations(timeout: 1) { (error:Error?) in
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
        waitForExpectations(timeout: 1) { (error:Error?) in
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

        var response = [String:Any]()
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
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }

    func testGetCheckinStatusWrongData() {
        // Given
        let asyncExpectation = expectation(description: "checkinStatus")

        var response = [String:Any]()
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
        waitForExpectations(timeout: 1) { (error:Error?) in
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
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }
}
