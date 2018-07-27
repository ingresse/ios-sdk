//
//  Copyright © 2017 Gondek. All rights reserved.
//

import XCTest
import IngresseSDK

class ResponseParserTests: XCTestCase {
    
    // MARK: - Request
    func testNilData() {
        // Given
        let builderExpectation = expectation(description: "builderCallback")
        
        var requestError = false
        
        // When
        do {
            try ResponseParser.build(URLResponse(), data: nil) { (response:[String : Any]) in }
        } catch IngresseException.requestError {
            requestError = true
            builderExpectation.fulfill()
        } catch {
            XCTFail("Error")
        }
        
        // Then
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssertTrue(requestError)
        }
    }
    
    func testNilResponse() {
        // Given
        let builderExpectation = expectation(description: "builderCallback")
        
        var requestError = false
        
        // When
        do {
            try ResponseParser.build(nil, data: Data()) { (response:[String : Any]) in }
        } catch IngresseException.requestError {
            requestError = true
            builderExpectation.fulfill()
        } catch {
            XCTFail("Error")
        }
        
        // Then
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssertTrue(requestError)
        }
    }
    
    func testInvalidData() {
        // Given
        let builderExpectation = expectation(description: "builderCallback")
        
        var requestError = false
        
        // When
        do {
            try ResponseParser.build(URLResponse(), data: Data()) { (response:[String : Any]) in }
        } catch IngresseException.jsonParserError {
            requestError = true
            builderExpectation.fulfill()
        } catch {
            XCTFail("Error")
        }
        
        // Then
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssertTrue(requestError)
        }
    }

    // MARK: - API Error
    func testAPIError() {
        // Given
        let builderExpectation = expectation(description: "builderCallback")

        var response = [String: Any]()
        response["responseData"] = "[Ingresse Exception Error] Error"
        response["responseError"] = [
            "code": 1,
            "message": "message",
            "category": "category"
        ]

        var requestError = false
        var apiError: APIError?

        let data = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        // When
        do {
            try ResponseParser.build(URLResponse(), data: data) { (_) in }
        } catch IngresseException.apiError(let error) {
            requestError = true
            apiError = error
            builderExpectation.fulfill()
        } catch {
            XCTFail("Error")
        }

        // Then
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssertTrue(requestError)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.error, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    func testAPIErrorInvalidData() {
        // Given
        let builderExpectation = expectation(description: "builderCallback")

        var response = [String: Any]()
        response["responseData"] = "[Ingresse Exception Error] Error"
        response["responseError"] = [
            "message": "message",
            "category": "category"
        ]

        var requestError = false

        let data = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        // When
        do {
            try ResponseParser.build(URLResponse(), data: data) { (_) in }
        } catch IngresseException.jsonParserError {
            requestError = true
            builderExpectation.fulfill()
        } catch {
            XCTFail("Error")
        }

        // Then
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssertTrue(requestError)
        }
    }

    func testAPIErrorInvalidString() {
        // Given
        let builderExpectation = expectation(description: "builderCallback")

        var response = [String: Any]()
        response["responseData"] = "Invalid String"

        var requestError = false

        let data = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        // When
        do {
            try ResponseParser.build(URLResponse(), data: data) { (_) in }
        } catch IngresseException.genericError {
            requestError = true
            builderExpectation.fulfill()
        } catch {
            XCTFail("Error")
        }

        // Then
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssertTrue(requestError)
        }
    }

    // MARK: Response
    func testResponse() {
        // Given
        let asyncExpectation = expectation(description: "builderCallback")

        var response = [String: Any]()
        response["responseData"] = ["result":"result"]

        var success = false
        var result: [String: Any]?

        let data = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        // When
        try? ResponseParser.build(URLResponse(), data: data) { (responseData) in
            success = true
            result = responseData
            asyncExpectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?["result"] as? String, "result")
        }
    }

    func testResponseArray() {
        // Given
        let asyncExpectation = expectation(description: "builderCallback")

        var response = [String: Any]()
        response["responseData"] = [["result":"result"]]

        var success = false
        var result: [String: Any]?

        let data = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        // When
        try? ResponseParser.build(URLResponse(), data: data) { (responseData) in
            success = true
            result = responseData
            asyncExpectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            let list = result?["data"] as? [[String:Any]]
            XCTAssertNotNil(list)
            XCTAssertEqual(list?[0]["result"] as? String, "result")
        }
    }

    func testEventsResponse() {
        // Given
        let asyncExpectation = expectation(description: "builderCallback")

        var response = [String: Any]()
        response["data"] = ["result":"result"]

        var success = false
        var result: [String: Any]?

        let data = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        // When
        try? ResponseParser.build(URLResponse(), data: data) { (responseData) in
            success = true
            result = responseData
            asyncExpectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?["result"] as? String, "result")
        }
    }

    func testEventsResponseArray() {
        // Given
        let asyncExpectation = expectation(description: "builderCallback")

        var response = [String: Any]()
        response["data"] = [["result":"result"]]

        var success = false
        var result: [String: Any]?

        let data = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        // When
        try? ResponseParser.build(URLResponse(), data: data) { (responseData) in
            success = true
            result = responseData
            asyncExpectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssert(success)
            XCTAssertNotNil(result)
            let list = result?["data"] as? [[String:Any]]
            XCTAssertNotNil(list)
            XCTAssertEqual(list?[0]["result"] as? String, "result")
        }
    }

    func testInvalidResponse() {
        // Given
        let asyncExpectation = expectation(description: "builderCallback")

        var response = [String: Any]()
        response["response"] = "Invalid Response"

        var requestError = false

        let data = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)

        // When
        do {
            try ResponseParser.build(URLResponse(), data: data) { (_) in }
        } catch IngresseException.jsonParserError {
            requestError = true
            asyncExpectation.fulfill()
        } catch {
            XCTFail("Error")
        }

        // Then
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssertTrue(requestError)
        }
    }
}
