//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class SearchServiceTests: XCTestCase {
    var restClient: MockClient!
    var client: IngresseClient!
    var service: SearchService!
    
    override func setUp() {
        super.setUp()

        restClient = MockClient()
        client = IngresseClient(apiKey: "1234", userAgent: "", restClient: restClient)
        service = IngresseService(client: client).search
    }
    
    // MARK: - Friends
    func testGetFriends() {
        // Given
        let asyncExpectation = expectation(description: "getFriends")

        var response = [String: Any]()
        response["data"] = []

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: [User]?

        // When
        service.getFriends("1234-token", queryString: "name", limit: 12, onSuccess: { (users) in
            success = true
            result = users
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }
    
    func testGetFriendsWrongData() {
        // Given
        let asyncExpectation = expectation(description: "getFriends")

        var response = [String: Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.getFriends("1234-token", queryString: "name", limit: 12, onSuccess: { (_) in }, onError: { (error) in
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

    func testGetFriendsFail() {
        // Given
        let asyncExpectation = expectation(description: "getFriends")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getFriends("1234-token", queryString: "name", limit: 12, onSuccess: { (_) in }, onError: { (error) in
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

    // MARK: - Events
    func testGetEvents() {
        // Given
        let asyncExpectation = expectation(description: "getEvents")

        var response = [String: Any]()
        response["total"] = 10
        response["hits"] = [[:]]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: [NewEvent]?
        var totalResults: Int?

        // When
        service.getEvents(eventTitle: "title", onSuccess: { (events, total) in
            success = true
            result = events
            totalResults = total
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            XCTAssertNotNil(totalResults)
            XCTAssertEqual(totalResults, 10)
        }
    }

    func testGetEventsWrongData() {
        // Given
        let asyncExpectation = expectation(description: "getEvents")

        var response = [String: Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.getEvents(eventTitle: "title", onSuccess: { (_, _) in }, onError: { (error) in
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

    func testGetEventsFail() {
        // Given
        let asyncExpectation = expectation(description: "getEvents")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getEvents(eventTitle: "title", onSuccess: { (_, _) in }, onError: { (error) in
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

    // MARK: - Events with id
    func testGetEventsWithId() {
        // Given
        let asyncExpectation = expectation(description: "getEvents")

        var response = [String: Any]()
        response["hits"] = [[:]]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: [NewEvent]?

        // When
        service.getEvents(eventId: "eventId", onSuccess: { (events) in
            success = true
            result = events
            asyncExpectation.fulfill()
        }, onError: { (error) in })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }

    func testGetEventsWithIdWrongData() {
        // Given
        let asyncExpectation = expectation(description: "getEvents")

        var response = [String: Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.getEvents(eventId: "eventId", onSuccess: { (_) in }, onError: { (error) in
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

    func testGetEventsWithIdFail() {
        // Given
        let asyncExpectation = expectation(description: "getEvents")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getEvents(eventId: "eventId", onSuccess: { (_) in }, onError: { (error) in
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
