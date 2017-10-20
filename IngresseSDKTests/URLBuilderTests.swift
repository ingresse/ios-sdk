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
    
    var builder: URLBuilder!
    
    override func setUp() {
        super.setUp()

        let client = IngresseClient(publicKey: "1234", privateKey: "2345", urlHost: "https://api.ingresse.com/")
        builder = URLBuilder(client: client)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    public func testMakeURL() {
        let authString = builder.generateAuthString(publicKey: "1234", privateKey: "2345")
        let expected = "https://api.ingresse.com/test/?param1=value1&param2=value2&\(authString)"
        
        let generated = builder
            .setHost("https://api.ingresse.com/")
            .setPath("test/")
            .setKeys(publicKey: "1234", privateKey: "2345")
            .addParameter(key: "param1", value: "value1")
            .addParameter(key: "param2", value: "value2")
            .build()
        
        XCTAssertEqual(expected, generated)
    }
    
    public func testMakeURLNoParameters() {
        let authString = builder.generateAuthString(publicKey: "1234", privateKey: "2345")
        let expected = "https://api.ingresse.com/test/?\(authString)"
        
        let generated = builder
            .setHost("https://api.ingresse.com/")
            .setPath("test/")
            .setKeys(publicKey: "1234", privateKey: "2345")
            .build()
        
        XCTAssertEqual(expected, generated)
    }
    
    public func testGetTimeStamp() {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        df.timeZone = TimeZone(abbreviation: "GMT")
        df.locale = Locale(identifier: "en_US_POSIX")
        
        let expected = df.string(from: Date()).removingPercentEncoding!
        
        let generated = builder.getTimestamp()
        
        XCTAssertEqual(expected, generated)
    }
    
    public func testGetSignature() {
        let timestamp = builder.getTimestamp()
        let data = "1234".appending(timestamp)
        
        let expected = HMACSHA1.hash(data, key: "2345").stringWithPercentEncoding()
        let generated = builder.getSignature("1234", "2345", timestamp)
        
        XCTAssertEqual(expected, generated)
    }
    
    public func testGetAuthString() {
        let timestamp = builder.getTimestamp()
        let signature = builder.getSignature("1234", "2345", timestamp)
        
        let expected = "publickey=1234&signature=\(signature)&timestamp=\(timestamp)"
        let generated = builder.generateAuthString(publicKey: "1234", privateKey: "2345")
        
        XCTAssertEqual(expected, generated)
    }
}
