//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class MyTicketsServiceTests: XCTestCase {
    
    var restClient: MockClient!
    var client: IngresseClient!
    var service: MyTicketsService!

    override func setUp() {
        super.setUp()

        restClient = MockClient()
        client = IngresseClient(apiKey: "1234", userAgent: "", restClient: restClient)
        service = IngresseService(client: client).myTickets
    }

    // MARK: - User Wallet
    func testGetUserWallet() {
        // Given
        let asyncExpectation = expectation(description: "userWallet")

        var response = [String:Any]()
        response["data"] = [["id": 1]]
        response["paginationInfo"] = ["currentPage": 1, "lastPage": 10, "totalResults": 1000, "pageSize": 100]

        restClient.response = response
        restClient.shouldFail = false

        let delegate = WalletSyncDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getUserWallet(userId: "1234", userToken: "1234-token", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didSyncItemsPageCalled)
            XCTAssertNotNil(delegate.resultData)
            XCTAssertNotNil(delegate.resultPage)
            XCTAssertEqual(delegate.resultPage?.currentPage, 1)
            XCTAssertEqual(delegate.resultPage?.lastPage, 10)
            XCTAssertEqual(delegate.resultPage?.totalResults, 1000)
            XCTAssertEqual(delegate.resultPage?.pageSize, 100)
            XCTAssertEqual(delegate.resultData?[0].id, 1)
        }
    }

    func testGetUserWalletWrongData() {
        // Given
        let asyncExpectation = expectation(description: "userWallet")

        var response = [String:Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        let delegate = WalletSyncDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getUserWallet(userId: "1234", userToken: "1234-token", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didFailSyncItemsCalled)
            XCTAssertNotNil(delegate.syncError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(delegate.syncError?.code, defaultError.code)
            XCTAssertEqual(delegate.syncError?.message, defaultError.message)
        }
    }
    
    func testGetUserWalletFail() {
        // Given
        let asyncExpectation = expectation(description: "userWallet")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        let delegate = WalletSyncDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getUserWallet(userId: "1234", userToken: "1234-token", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didFailSyncItemsCalled)
            XCTAssertNotNil(delegate.syncError)
            XCTAssertEqual(delegate.syncError?.code, 1)
            XCTAssertEqual(delegate.syncError?.message, "message")
            XCTAssertEqual(delegate.syncError?.category, "category")
        }
    }
    
    // MARK: - User Tickets
    func testGetUserTickets() {
        // Given
        let asyncExpectation = expectation(description: "userTickets")

        var response = [String:Any]()
        response["data"] = [["id": 1]]
        response["paginationInfo"] = ["currentPage": 1, "lastPage": 10, "totalResults": 1000, "pageSize": 100]

        restClient.response = response
        restClient.shouldFail = false

        let delegate = TicketSyncDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getUserTickets(userId: "1234", userToken: "1234-token", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didSyncTicketsPageCalled)
            XCTAssertNotNil(delegate.resultData)
            XCTAssertNotNil(delegate.resultPage)
            XCTAssertEqual(delegate.resultPage?.currentPage, 1)
            XCTAssertEqual(delegate.resultPage?.lastPage, 10)
            XCTAssertEqual(delegate.resultPage?.totalResults, 1000)
            XCTAssertEqual(delegate.resultPage?.pageSize, 100)
            XCTAssertEqual(delegate.resultData?[0].id, 1)
        }
    }
    
    func testGetUserTicketsWrongData() {
        // Given
        let asyncExpectation = expectation(description: "userTickets")

        var response = [String:Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        let delegate = TicketSyncDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getUserTickets(userId: "1234", userToken: "1234-token", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didFailSyncTicketsCalled)
            XCTAssertNotNil(delegate.syncError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(delegate.syncError?.code, defaultError.code)
            XCTAssertEqual(delegate.syncError?.message, defaultError.message)
        }
    }
    
    func testGetUserTicketsFail() {
        // Given
        let asyncExpectation = expectation(description: "userTickets")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        let delegate = TicketSyncDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getUserTickets(userId: "1234", userToken: "1234-token", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didFailSyncTicketsCalled)
            XCTAssertNotNil(delegate.syncError)
            XCTAssertEqual(delegate.syncError?.code, 1)
            XCTAssertEqual(delegate.syncError?.message, "message")
            XCTAssertEqual(delegate.syncError?.category, "category")
        }
    }
}
