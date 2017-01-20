//
//  URLBuilderTests.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/13/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import XCTest
import IngresseSDK

class URLBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    public func testMakeURL() {
        let authString = URLBuilder.generateAuthString(publicKey: "1234", privateKey: "2345")
        let expected = "https://api.ingresse.com/test/\(authString)&param1=value1&param2=value2"
        
        let params = ["param1":"value1","param2":"value2"]
        
        let generated = URLBuilder.makeURL(host: "https://api.ingresse.com/", path: "test/", publicKey: "1234", privateKey: "2345", parameters: params)
        
        XCTAssertEqual(expected, generated)
    }
    
    public func testGetTimeStamp() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        df.timeZone = TimeZone(abbreviation: "GMT")
        df.locale = Locale(identifier: "en_US_POSIX")
        
        let expected = df.string(from: Date()).removingPercentEncoding!
        
        let generated = URLBuilder.getTimestamp()
        
        XCTAssertEqual(expected, generated)
    }
    
    public func testGetSignature() {
        let timestamp = URLBuilder.getTimestamp()
        let data = "1234".appending(timestamp)
        
        let expected = HMACSHA1.hash(data, key: "2345")
        let generated = URLBuilder.getSignature("1234", "2345")
        
        XCTAssertEqual(expected, generated)
    }
    
    public func testGetAuthString() {
        let timestamp = URLBuilder.getTimestamp()
        let signature = URLBuilder.getSignature("1234", "2345")
        
        let expected = "?publickey=1234&signature=\(signature)&timestamp=\(timestamp)"
        let generated = URLBuilder.generateAuthString(publicKey: "1234", privateKey: "2345")
        
        XCTAssertEqual(expected, generated)
    }
}
