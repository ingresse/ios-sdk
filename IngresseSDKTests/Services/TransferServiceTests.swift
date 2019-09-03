//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TransferServiceTests: XCTestCase {
    var restClient: MockClient!
    var client: IngresseClient!
    var service: TransfersService!
    
    override func setUp() {
        super.setUp()

        restClient = MockClient()
        client = IngresseClient(apiKey: "1234", userAgent: "", restClient: restClient)
        service = IngresseService(client: client).transfers
    }
    
    // MARK: - Recent Transfers
    func testGetRecentTransfers() {
        // Given
        let asyncExpectation = expectation(description: "recentTransfers")

        var response = [String: Any]()
        response["data"] = []

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: [Transfer]?

        // When
        service.getRecentTransfers(userID: "1234", userToken: "1234-token", limit: 12, onSuccess: { (users) in
            success = true
            result = users
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }

    func testGetRecentTransfersWrongData() {
        // Given
        let asyncExpectation = expectation(description: "recentTransfers")

        var response = [String: Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.getRecentTransfers(userID: "1234", userToken: "1234-token", limit: 12, onSuccess: { (_) in }, onError: { (error) in
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

    func testGetRecentTransfersFail() {
        // Given
        let asyncExpectation = expectation(description: "recentTransfers")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getRecentTransfers(userID: "1234", userToken: "1234-token", limit: 12, onSuccess: { (_) in }, onError: { (error) in
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

    // MARK: - Pending Transfers
    func testGetPendingTransfers() {
        // Given
        let asyncExpectation = expectation(description: "pendingTransfers")

        var response = [String: Any]()
        response["data"] = [["id": 1]]
        response["paginationInfo"] = ["currentPage": 1, "lastPage": 10, "totalResults": 1000, "pageSize": 100]

        restClient.response = response
        restClient.shouldFail = false

        let delegate = TicketTransfersDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getPendingTransfers("1234", userToken: "1234-token", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(delegate.didDownloadPendingTransfersCalled)
            XCTAssertNotNil(delegate.resultData)
            XCTAssertNotNil(delegate.resultPage)
            XCTAssertEqual(delegate.resultPage?.currentPage, 1)
            XCTAssertEqual(delegate.resultPage?.lastPage, 10)
            XCTAssertEqual(delegate.resultPage?.totalResults, 1000)
            XCTAssertEqual(delegate.resultPage?.pageSize, 100)
            XCTAssertEqual(delegate.resultData?[0].id, 1)
        }
    }
    
    func testGetPendingTransfersWrongData() {
        // Given
        let asyncExpectation = expectation(description: "pendingTransfers")

        var response = [String: Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        let delegate = TicketTransfersDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getPendingTransfers("1234", userToken: "1234-token", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(delegate.didFailDownloadTransfersCalled)
            XCTAssertNotNil(delegate.syncError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(delegate.syncError?.code, defaultError.code)
            XCTAssertEqual(delegate.syncError?.message, defaultError.message)
        }
    }

    func testGetPendingTransfersFail() {
        // Given
        let asyncExpectation = expectation(description: "pendingTransfers")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        let delegate = TicketTransfersDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getPendingTransfers("1234", userToken: "1234-token", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(delegate.didFailDownloadTransfersCalled)
            XCTAssertNotNil(delegate.syncError)
            XCTAssertEqual(delegate.syncError?.code, 1)
            XCTAssertEqual(delegate.syncError?.message, "message")
            XCTAssertEqual(delegate.syncError?.category, "category")
        }
    }

    // MARK: - Update Transfer
    func testUpdateTransfer() {
        // Given
        let asyncExpectation = expectation(description: "updateTransfer")

        restClient.response = [:]
        restClient.shouldFail = false

        var success = false

        // When
        service.updateTransfer("accept", ticketID: "123456", transferID: "234567", userToken: "1234-token", onSuccess: {
            success = true
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(success)
        }
    }

    func testUpdateTransferFail() {
        // Given
        let asyncExpectation = expectation(description: "updateTransfer")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.updateTransfer("accept", ticketID: "123456", transferID: "234567", userToken: "1234-token", onSuccess: {}, onError: { (error) in
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

    // MARK: - Transfer Ticket
    func testTransferTicket() {
        // Given
        let asyncExpectation = expectation(description: "transferTicket")

        var response = [String: Any]()
        response["id"] = 1
        response["status"] = "accepted"
        response["saleTicketId"] = 2
        response["user"] = ["id": 3]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: NewTransfer?

        // When
        service.transferTicket("123456", toUser: "1234", userToken: "1234-token", onSuccess: { (data) in
            success = true
            result = data
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.id, 1)
            XCTAssertEqual(result?.status, "accepted")
            XCTAssertEqual(result?.saleTicketId, 2)
            XCTAssertEqual(result?.user?.id, 3)
        }
    }

    func testTransferTicketWrongData() {
        // Given
        let asyncExpectation = expectation(description: "transferTicket")

        var response = [String: Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.transferTicket("123456", toUser: "1234", userToken: "1234-token", onSuccess: { (_) in }, onError: { (error) in
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

    func testTransferTicketFail() {
        // Given
        let asyncExpectation = expectation(description: "transferTicket")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.transferTicket("123456", toUser: "1234", userToken: "1234-token", onSuccess: { (_) in }, onError: { (error) in
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

    // MARK: - Return Ticket
    func testReturnTicket() {
        // Given
        let asyncExpectation = expectation(description: "returnTicket")

        var response = [String: Any]()
        response["saleTicketId"] = 1

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: Int?

        // When
        service.returnTicket("123456", userToken: "1234-token", onSuccess: { (id) in
            success = true
            result = id
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result, 1)
        }
    }

    func testReturnTicketWrongData() {
        // Given
        let asyncExpectation = expectation(description: "returnTicket")

        var response = [String: Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.returnTicket("123456", userToken: "1234-token", onSuccess: { (_) in }, onError: { (error) in
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

    func testReturnTicketFail() {
        // Given
        let asyncExpectation = expectation(description: "returnTicket")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.returnTicket("123456", userToken: "1234-token", onSuccess: { (_) in }, onError: { (error) in
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
