//
//  IngresseAPIBuilderTests.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/16/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import XCTest
import IngresseSDK

class ResponseParserTests: XCTestCase {
    
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
            try ResponseParser.build(URLResponse(), data: nil) { (response:[String : Any]) in }
        } catch IngresseException.requestError {
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
            try ResponseParser.build(nil, data: Data()) { (response:[String : Any]) in }
        } catch IngresseException.requestError {
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
            try ResponseParser.build(URLResponse(), data: Data()) { (response:[String : Any]) in }
        } catch IngresseException.jsonParserError {
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
