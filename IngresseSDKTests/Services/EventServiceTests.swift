//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class EventServiceTests: XCTestCase {
    
    var restClient: MockClient!
    var client: IngresseClient!
    var service: EventService!

    override func setUp() {
        super.setUp()

        restClient = MockClient()
        client = IngresseClient(publicKey: "1234", privateKey: "2345", restClient: restClient)
        service = IngresseService(client: client).event
    }

    // MARK: - Event Attributes
    func testGetEventAttributes() {
        // Given
        let asyncExpectation = expectation(description: "eventAttributes")

        var response = [String:Any]()
        response["data"] = []

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: EventAttributes?

        // When
        service.getEventAttributes(eventId: "1234", onSuccess: { (response) in
            success = true
            result = response
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }

    func testGetTransferHistoryFail() {
        // Given
        let asyncExpectation = expectation(description: "eventAttributes")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getEventAttributes(eventId: "1234", onSuccess: { (_) in }, onError: { (error) in
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

    // MARK: - Advertisement
    func testGetAdvertisement() {
        // Given
        let asyncExpectation = expectation(description: "advertisement")

        var response = [String:Any]()
        response["advertisement"] = ["mobile":
            ["cover": ["image": "image"]]
        ]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: Advertisement?

        // When
        service.getAdvertisement(ofEvent: "1234", onSuccess: { (ads) in
            success = true
            result = ads
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }

    func testGetAdvertisementWrongData() {
        // Given
        let asyncExpectation = expectation(description: "advertisement")

        var response = [String:Any]()
        response["advertisement"] = nil

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.getAdvertisement(ofEvent: "1234", onSuccess: { (_) in }, onError: { (error) in
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

    func testGetAdvertisementFail() {
        // Given
        let asyncExpectation = expectation(description: "advertisement")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getAdvertisement(ofEvent: "1234", onSuccess: { (_) in }, onError: { (error) in
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

    // MARK: - Events
    func testGetEvents() {
        // Given
        let asyncExpectation = expectation(description: "events")

        var response = [String:Any]()
        response["total"] = 15
        response["hits"] = [["_source": ["id": 1]]]

        restClient.response = response
        restClient.shouldFail = false

        let delegate = NewEventSyncDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getEvents(from: "state", ofCategories: [0], andSearchTerm: "search", page: ElasticPagination(), delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didSyncEventsCalled)
            XCTAssertNotNil(delegate.resultData)
            XCTAssertNotNil(delegate.resultPage)
            XCTAssertEqual(delegate.resultPage?.total, 15)
            XCTAssertEqual(delegate.resultData?[0].id, 1)
        }
    }

    func testGetEventsWrongData() {
        // Given
        let asyncExpectation = expectation(description: "events")

        var response = [String:Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        let delegate = NewEventSyncDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getEvents(from: "state", ofCategories: [0], andSearchTerm: "search", page: ElasticPagination(), delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didFailCalled)
            XCTAssertNotNil(delegate.syncError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(delegate.syncError?.code, defaultError.code)
            XCTAssertEqual(delegate.syncError?.message, defaultError.message)
        }
    }

    func testGetEventsFail() {
        // Given
        let asyncExpectation = expectation(description: "events")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        let delegate = NewEventSyncDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getEvents(from: "state", ofCategories: [0], andSearchTerm: "search", page: ElasticPagination(), delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didFailCalled)
            XCTAssertNotNil(delegate.syncError)
            XCTAssertEqual(delegate.syncError?.code, 1)
            XCTAssertEqual(delegate.syncError?.message, "message")
            XCTAssertEqual(delegate.syncError?.category, "category")
        }
    }

    // MARK: - Categories
    func testGetCategories() {
        // Given
        let asyncExpectation = expectation(description: "categories")

        var response = [String:Any]()
        response["data"] = [[
            "id": 1,
            "name": "name",
            "slug": "slug",
            "public": true]
        ]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: [IngresseSDK.Category]?

        // When
        service.getCategories(onSuccess: { (data) in
            success = true
            result = data
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?[0].id, 1)
            XCTAssertEqual(result?[0].name, "name")
            XCTAssertEqual(result?[0].slug, "slug")
            XCTAssertEqual(result?[0].isPublic, true)
        }
    }
    
    func testGetCategoriesWrongData() {
        // Given
        let asyncExpectation = expectation(description: "categories")

        var response = [String:Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.getCategories(onSuccess: { (_) in }, onError: { (error) in
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
    
    func testGetCategoriesFail() {
        // Given
        let asyncExpectation = expectation(description: "categories")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getCategories(onSuccess: { (_) in }, onError: { (error) in
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
    
    // MARK: - Get Featured Events
    func testGetFeaturedEvents() {
        // Given
        let asyncExpectation = expectation(description: "featuredEvents")

        var response = [String:Any]()
        response["data"] = [[
            "banner": "banner",
            "target": "target"]
        ]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: [Highlight]?

        // When
        service.getFeaturedEvents(from: "state", onSuccess: { (data) in
            success = true
            result = data
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?[0].banner, "banner")
            XCTAssertEqual(result?[0].target, "target")
        }
    }
    
    func testGetFeaturedEventsWrongData() {
        // Given
        let asyncExpectation = expectation(description: "featuredEvents")

        var response = [String:Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.getFeaturedEvents(from: "state", onSuccess: { (_) in }, onError: { (error) in
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

    func testGetFeaturedEventsFail() {
        // Given
        let asyncExpectation = expectation(description: "featuredEvents")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getFeaturedEvents(from: "state", onSuccess: { (_) in }, onError: { (error) in
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
