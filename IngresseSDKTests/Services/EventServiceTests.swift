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
        client = IngresseClient(apiKey: "1234", userAgent: "", restClient: restClient)
        service = IngresseService(client: client).event
    }
}

// MARK: - Event Attributes
extension EventServiceTests {
    func testGetEventAttributes() {
        // Given
        let asyncExpectation = expectation(description: "eventAttributes")

        var response = [String: Any]()
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
        waitForExpectations(timeout: 1) { (_) in
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
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }
}

// MARK: - Advertisement
extension EventServiceTests {
    func testGetAdvertisement() {
        // Given
        let asyncExpectation = expectation(description: "advertisement")

        var response = [String: Any]()
        response["advertisement"] = ["mobile":
            ["cover": ["image": "image"]]
        ]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: Advertisement?

        // When
        service.getAdvertisement(ofEvent: 1234, onSuccess: { (ads) in
            success = true
            result = ads
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }

    func testGetAdvertisementWrongData() {
        // Given
        let asyncExpectation = expectation(description: "advertisement")

        var response = [String: Any]()
        response["advertisement"] = nil

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.getAdvertisement(ofEvent: 1234, onSuccess: { (_) in }, onError: { (error) in
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
        service.getAdvertisement(ofEvent: 1234, onSuccess: { (_) in }, onError: { (error) in
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

// MARK: - Events
extension EventServiceTests {
    func testGetEvents() {
        // Given
        let asyncExpectation = expectation(description: "events")

        var response = [String: Any]()
        response["total"] = 15
        response["hits"] = [["_source": ["id": 1]]]

        restClient.response = response
        restClient.shouldFail = false

        let delegate = NewEventSyncDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getEvents(from: "state", ofCategories: [0], andSearchTerm: "search", page: ElasticPagination(), delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (_) in
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

        var response = [String: Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        let delegate = NewEventSyncDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getEvents(from: "state", ofCategories: [0], andSearchTerm: "search", page: ElasticPagination(), delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (_) in
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
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(delegate.didFailCalled)
            XCTAssertNotNil(delegate.syncError)
            XCTAssertEqual(delegate.syncError?.code, 1)
            XCTAssertEqual(delegate.syncError?.message, "message")
            XCTAssertEqual(delegate.syncError?.category, "category")
        }
    }
}

// MARK: - Categories
extension EventServiceTests {
    func testGetCategories() {
        // Given
        let asyncExpectation = expectation(description: "categories")

        var response = [String: Any]()
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
        waitForExpectations(timeout: 1) { (_) in
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

        var response = [String: Any]()
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
        waitForExpectations(timeout: 1) { (_) in
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
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }
}

// MARK: - Get Featured Events
extension EventServiceTests {
    func testGetFeaturedEvents() {
        // Given
        let asyncExpectation = expectation(description: "featuredEvents")

        var response = [String: Any]()
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
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?[0].banner, "banner")
            XCTAssertEqual(result?[0].target, "target")
        }
    }
    
    func testGetFeaturedEventsWrongData() {
        // Given
        let asyncExpectation = expectation(description: "featuredEvents")

        var response = [String: Any]()
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
        waitForExpectations(timeout: 1) { (_) in
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
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }
}

// MARK: - Event Details
extension EventServiceTests {
    func testGetEvent() {
        // Given
        let asyncExpectation = expectation(description: "event")

        var json = [String: Any]()
        json["id"] = 1
        json["title"] = "eventTitle"
        json["link"] = "eventLink"
        json["type"] = "eventType"
        json["poster"] = "eventPoster"
        json["status"] = "eventStatus"
        json["rsvpTotal"] = 100
        json["saleEnabled"] = true
        json["description"] = "eventDescription"

        restClient.response = json
        restClient.shouldFail = false

        var success = false
        var result: Event?

        // When
        service.getEventDetails(eventId: "1234", onSuccess: { (data) in
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

    func testGetEventWithSlug() {
        // Given
        let asyncExpectation = expectation(description: "event")

        var json = [String: Any]()
        json["id"] = 1
        json["title"] = "eventTitle"
        json["link"] = "eventLink"
        json["type"] = "eventType"
        json["poster"] = "eventPoster"
        json["status"] = "eventStatus"
        json["rsvpTotal"] = 100
        json["saleEnabled"] = true
        json["description"] = "eventDescription"

        restClient.response = json
        restClient.shouldFail = false

        var success = false
        var result: Event?

        // When
        service.getEventDetails(eventId: "", slug: "event-link", onSuccess: { (data) in
            success = true
            result = data
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            guard let request = self.restClient.requestCalled,
                let url = request.url?.absoluteString else {
                XCTFail("Invalid Request")
                return
            }
            XCTAssert(url.contains("method=identify"))
            XCTAssert(url.contains("link=event-link"))
        }
    }

    func testGetEventWrongData() {
        // Given
        let asyncExpectation = expectation(description: "event")

        var response = [String: Any]()
        response["wrongKey"] = []

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiEvent: Event?

        // When
        service.getEventDetails(eventId: "1234", onSuccess: { (event) in
            success = true
            apiEvent = event
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(success)
            XCTAssertNotNil(apiEvent)
            XCTAssertEqual(apiEvent?.id, 0)
            XCTAssertNil(apiEvent?.planner)
            XCTAssertNil(apiEvent?.venue)
        }
    }

    func testGetEventFail() {
        // Given
        let asyncExpectation = expectation(description: "event")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getEventDetails(eventId: "1234", onSuccess: { (_) in }, onError: { (error) in
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

// MARK: - RSVP Response
extension EventServiceTests {
    func testRSVPResponse() {
        // Given
        let asyncExpectation = expectation(description: "rsvpResponse")

        var json = [String: Any]()
        json["success"] = true

        restClient.response = json
        restClient.shouldFail = false

        var success = false

        var request = Request.Event.AddToRSVP()
        request.eventId = "1234"
        request.userToken = "12345-token"

        // When
        service.addUserToRSVP(request: request, onSuccess: { (status) in
            success = status
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(success)
        }
    }

    func testRSVPResponseWrongData() {
        // Given
        let asyncExpectation = expectation(description: "rsvpResponse")

        var response = [String: Any]()
        response["status"] = nil

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        var request = Request.Event.AddToRSVP()
        request.eventId = "1234"
        request.userToken = "12345-token"

        // When
        service.addUserToRSVP(request: request, onSuccess: { (_) in }, onError: { (error) in
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

    func testRSVPResponseFail() {
        // Given
        let asyncExpectation = expectation(description: "rsvpResponse")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        var request = Request.Event.AddToRSVP()
        request.eventId = "1234"
        request.userToken = "12345-token"

        // When
        service.addUserToRSVP(request: request, onSuccess: { (_) in }, onError: { (error) in
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

// MARK: - Get Session Details
extension EventServiceTests {
    func testGetSessionDetails() {
        // Given
        let asyncExpectation = expectation(description: "session")

        var data = [String: Any]()
        data["id"] = 1
        data["name"] = "eventName"
        data["status"] = "status"
        data["description"] = "description"
        data["type"] = []

        var json = [String: Any]()
        json["data"] = [data]

        restClient.response = json
        restClient.shouldFail = false

        var success = false
        var result: [TicketGroup]?

        // When
        service.getSessionDetails(eventId: "1234", sessionId: "4321", onSuccess: { (response) in
            success = true
            result = response
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }

    func testGetSessionDetailsWrongData() {
        // Given
        let asyncExpectation = expectation(description: "session")

        var response = [String: Any]()
        response["wrongKey"] = []

        restClient.response = response
        restClient.shouldFail = false

        var apiError: APIError?
        var success = false

        // When
        service.getSessionDetails(eventId: "1234", sessionId: "4321", onSuccess: { (_) in }, onError: { (error) in
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

    func testGetSessionDetailsFail() {
        // Given
        let asyncExpectation = expectation(description: "session")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getSessionDetails(eventId: "1234", sessionId: "4321", onSuccess: { (_) in }, onError: { (error) in
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

// MARK: - Get Event PassKey
extension EventServiceTests {
    func testGetEventPasskey() {
        // Given
        let asyncExpectation = expectation(description: "session")

        var data = [String: Any]()
        data["id"] = 1
        data["name"] = "eventName"
        data["status"] = "status"
        data["description"] = "description"
        data["type"] = []

        var json = [String: Any]()
        json["data"] = [data]

        restClient.response = json
        restClient.shouldFail = false

        var success = false
        var result: [TicketGroup]?

        // When
        service.getEventPassKey(eventId: "1234", passkeyCode: "passkey", onSuccess: { (response) in
            success = true
            result = response
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }

    func testGetEventPasskeyWrongData() {
        // Given
        let asyncExpectation = expectation(description: "session")

        var response = [String: Any]()
        response["wrongKey"] = []

        restClient.response = response
        restClient.shouldFail = false

        var apiError: APIError?
        var success = false

        // When
        service.getEventPassKey(eventId: "1234", passkeyCode: "passkey", onSuccess: { (_) in }, onError: { (error) in
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

    func testGetEventPasskeyFail() {
        // Given
        let asyncExpectation = expectation(description: "session")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getEventPassKey(eventId: "1234", passkeyCode: "passkey", onSuccess: { (_) in }, onError: { (error) in
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

// MARK: - Get Event Passports PassKey
extension EventServiceTests {
    func testGetEventPassportsPasskey() {
        // Given
        let asyncExpectation = expectation(description: "session")

        var data = [String: Any]()
        data["id"] = 1
        data["name"] = "eventName"
        data["status"] = "status"
        data["description"] = "description"
        data["type"] = []

        var json = [String: Any]()
        json["data"] = [data]

        restClient.response = json
        restClient.shouldFail = false

        var success = false
        var result: [TicketGroup]?

        // When
        service.getEventPassportsPassKey(eventId: "1234", passkeyCode: "passkey", onSuccess: { (response) in
            success = true
            result = response
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssert(success)
            XCTAssertNotNil(result)
        }
    }

    func testGetEventPassportsPasskeyWrongData() {
        // Given
        let asyncExpectation = expectation(description: "session")

        var response = [String: Any]()
        response["wrongKey"] = []

        restClient.response = response
        restClient.shouldFail = false

        var apiError: APIError?
        var success = false

        // When
        service.getEventPassportsPassKey(eventId: "1234", passkeyCode: "passkey", onSuccess: { (_) in }, onError: { (error) in
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

    func testGetEventPassportsPasskeyFail() {
        // Given
        let asyncExpectation = expectation(description: "session")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getEventPassportsPassKey(eventId: "1234", passkeyCode: "passkey", onSuccess: { (_) in }, onError: { (error) in
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
