//
//  Copyright © 2017 Gondek. All rights reserved.
//

import XCTest
import IngresseSDK

class URLBuilderTests: XCTestCase {
    
    var builder: URLBuilder!
    
    override func setUp() {
        super.setUp()

        let client = IngresseClient(apiKey: "1234", userAgent: "", urlHost: "https://api.ingresse.com/")
        builder = URLBuilder(client: client)
    }
    
    public func testMakeURL() {
        // Given
        let authString = builder.generateAuthString(apiKey: "1234")
        let expected = "https://api.ingresse.com/test/?param1=value1&param2=value2&\(authString)"
        let expected2 = "https://api.ingresse.com/test/?param2=value2&param1=value1&\(authString)"
        
        // When
        let generated = builder
            .setHost("https://api.ingresse.com/")
            .setPath("test/")
            .setKeys(apiKey: "1234")
            .addParameter(key: "param1", value: "value1")
            .addParameter(key: "param2", value: "value2")
            .build()
        
        // Then
        XCTAssert(generated == expected || generated == expected2)
    }
    
    public func testMakeURLNoParameters() {
        // Given
        let authString = builder.generateAuthString(apiKey: "1234")
        let expected = "https://api.ingresse.com/test/?\(authString)"
        
        // When
        let generated = builder
            .setHost("https://api.ingresse.com/")
            .setPath("test/")
            .setKeys(apiKey: "1234")
            .build()
        
        // Then
        XCTAssertEqual(expected, generated)
    }
    
    public func testGetAuthString() {
        // When
        let expected = "apikey=1234"
        let generated = builder.generateAuthString(apiKey: "1234")
        
        // Then
        XCTAssertEqual(expected, generated)
    }
}
