//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class RestClientTests: XCTestCase {
    var client: RestClient!

    override func setUp() {
        client = RestClient()
    }

    // MARK: - GET
    func testGET() {
        // Given
        let asyncExpectation = expectation(description: "GET")

        let session = URLSessionMock()
        var response = [String: Any]()
        response["responseData"] = ["id": 1, "name": "name"]

        let data = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        session.data = data
        session.error = nil
        session.response = URLResponse()

        client.session = session

        var success: Bool = false
        var result: [String: Any]?

        // When
        client.GET(url: "url", onSuccess: { (response) in
            success = true
            result = response
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?["id"] as? Int, 1)
            XCTAssertEqual(result?["name"] as? String, "name")
        }
    }

    func testGETWithError() {
        // Given
        let asyncExpectation = expectation(description: "GET")

        let session = URLSessionMock()
        let error = NSError(domain: "tests", code: 1, userInfo: nil)
        session.error = error

        let message = error.localizedDescription

        client.session = session

        var success = false
        var apiError: APIError?

        // When
        client.GET(url: "url", onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 0)
            XCTAssertEqual(apiError?.error, message)
        }
    }
    
    func testGETWithAPIError() {
        // Given
        let asyncExpectation = expectation(description: "GET")

        let session = URLSessionMock()
        var response = [String: Any]()
        response["responseData"] = "[Ingresse Exception Error] Error"
        response["responseError"] = [
            "code": 1,
            "message": "message",
            "category": "category"
        ]

        let data = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        session.data = data
        session.error = nil
        session.response = URLResponse()

        client.session = session

        var success: Bool = false
        var apiError: APIError?

        // When
        client.GET(url: "url", onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.error, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }
    
    func testGETWithGenericError() {
        // Given
        let asyncExpectation = expectation(description: "GET")

        let session = URLSessionMock()
        var response = [String: Any]()
        response["responseData"] = "Error"

        let data = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        session.data = data
        session.error = nil
        session.response = URLResponse()

        client.session = session

        var success: Bool = false
        var apiError: APIError?

        // When
        client.GET(url: "url", onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(apiError?.code, defaultError.code)
            XCTAssertEqual(apiError?.message, defaultError.message)
        }
    }
    
    // MARK: - POST
    func testPOST() {
        // Given
        let asyncExpectation = expectation(description: "POST")

        let session = URLSessionMock()
        var response = [String: Any]()
        response["responseData"] = ["id": 1, "name": "name"]

        let data = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        session.data = data
        session.error = nil
        session.response = URLResponse()

        client.session = session

        var success: Bool = false
        var result: [String: Any]?

        let parameters = ["id": 2]

        // When
        client.POST(url: "url", parameters: parameters, onSuccess: { (response) in
            success = true
            result = response
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?["id"] as? Int, 1)
            XCTAssertEqual(result?["name"] as? String, "name")
        }
    }
    
    func testPOSTWithError() {
        // Given
        let asyncExpectation = expectation(description: "POST")

        let session = URLSessionMock()
        let error = NSError(domain: "tests", code: 1, userInfo: nil)
        session.error = error

        let message = error.localizedDescription

        client.session = session

        var success = false
        var apiError: APIError?

        let parameters = ["id": 2]

        // When
        client.POST(url: "url", parameters: parameters, onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (_) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 0)
            XCTAssertEqual(apiError?.error, message)
        }
    }

    func testPOSTWithAPIError() {
        // Given
        let asyncExpectation = expectation(description: "POST")

        let session = URLSessionMock()
        var response = [String: Any]()
        response["responseData"] = "[Ingresse Exception Error] Error"
        response["responseError"] = [
            "code": 1,
            "message": "message",
            "category": "category"
        ]

        let data = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        session.data = data
        session.error = nil
        session.response = URLResponse()

        client.session = session

        var success: Bool = false
        var apiError: APIError?

        let parameters = ["id": 2]

        // When
        client.POST(url: "url", parameters: parameters, onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.error, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    func testPOSTWithGenericError() {
        // Given
        let asyncExpectation = expectation(description: "POST")

        let session = URLSessionMock()
        var response = [String: Any]()
        response["responseData"] = "Error"

        let data = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        session.data = data
        session.error = nil
        session.response = URLResponse()

        client.session = session

        var success: Bool = false
        var apiError: APIError?

        let parameters = ["id": 2]

        // When
        client.POST(url: "url", parameters: parameters, onSuccess: { (_) in }, onError: { (error) in
            success = false
            apiError = error
            asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(apiError?.code, defaultError.code)
            XCTAssertEqual(apiError?.message, defaultError.message)
        }
    }

    // MARK: - POST Data
    func testPOSTData() {
        // Given
        let asyncExpectation = expectation(description: "POST")

        let session = URLSessionMock()
        var response = [String: Any]()
        response["responseData"] = ["id": 1, "name": "name"]

        let responseData = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        session.data = responseData
        session.error = nil
        session.response = URLResponse()

        client.session = session

        var success: Bool = false
        var result: [String: Any]?

        let data = "bodyData".data(using: .utf8)

        // When
        client.POSTData(url: "url", data: data, JSONData: false, onSuccess: { (response) in
            success = true
            result = response
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?["id"] as? Int, 1)
            XCTAssertEqual(result?["name"] as? String, "name")

            let request = session.taskRequest
            XCTAssertNotNil(request)
            XCTAssertNil(request?.value(forHTTPHeaderField: "content-type"))
        }
    }

    func testPOSTDataJSON() {
        // Given
        let asyncExpectation = expectation(description: "POST")

        let session = URLSessionMock()
        var response = [String: Any]()
        response["responseData"] = ["id": 1, "name": "name"]

        let responseData = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        session.data = responseData
        session.error = nil
        session.response = URLResponse()

        client.session = session

        var success: Bool = false
        var result: [String: Any]?

        let data = "bodyData".data(using: .utf8)

        // When
        client.POSTData(url: "url", data: data, JSONData: true, onSuccess: { (response) in
            success = true
            result = response
            asyncExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?["id"] as? Int, 1)
            XCTAssertEqual(result?["name"] as? String, "name")

            let request = session.taskRequest
            XCTAssertNotNil(request)
            XCTAssertEqual(request?.value(forHTTPHeaderField: "content-type"), "application/json")
        }
    }
}
