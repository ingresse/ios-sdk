//
//  IngresseAPIBuilderTests.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/16/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import XCTest
import IngresseSDK

class IngresseAPIBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNilData() {
        let builderExpectation = expectation(description: "builderCallback")
        
        var requestError = false
        
        do {
            try IngresseAPIBuilder.build(URLResponse(), data: nil, error: nil) { (response:[String : Any]) in }
        } catch IngresseAPIError.requestError {
            requestError = true
            builderExpectation.fulfill()
        } catch {
            XCTFail("Error")
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssertTrue(requestError)
        }
    }
    
    func testNilResponse() {
        let builderExpectation = expectation(description: "builderCallback")
        
        var requestError = false
        
        do {
            try IngresseAPIBuilder.build(nil, data: Data(), error: nil) { (response:[String : Any]) in }
        } catch IngresseAPIError.requestError {
            requestError = true
            builderExpectation.fulfill()
        } catch {
            XCTFail("Error")
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssertTrue(requestError)
        }
    }
    
    func testInvalidData() {
        let builderExpectation = expectation(description: "builderCallback")
        
        var requestError = false
        
        do {
            try IngresseAPIBuilder.build(URLResponse(), data: Data(), error: nil) { (response:[String : Any]) in }
        } catch IngresseAPIError.jsonParserError {
            requestError = true
            builderExpectation.fulfill()
        } catch {
            XCTFail("Error")
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssertTrue(requestError)
        }
    }
}
