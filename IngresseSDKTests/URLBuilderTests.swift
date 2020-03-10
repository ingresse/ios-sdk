//
//  Copyright © 2017 Gondek. All rights reserved.
//

import XCTest
import IngresseSDK

class URLBuilderTests: XCTestCase {
    
    var builder: URLBuilder!
    
    override func setUp() {
        super.setUp()

        let client = IngresseClient(apiKey: "1234", userAgent: "", env: .prod)
        builder = URLBuilder(client: client)
    }
    
    public func testMakeURL() {

        // When
        let request = try? builder
            .setPath("test/")
            .setKeys(apiKey: "4321")
            .addParameter(key: "param1", value: "value1")
            .addParameter(key: "param2", value: "value2")
            .build()

        let generated = request?.url?.absoluteString ?? ""
        // Then

        XCTAssert(generated.contains("apikey=4321"))
        XCTAssert(generated.contains("param1=value1"))
        XCTAssert(generated.contains("param2=value2"))
    }
    
    public func testMakeURLNoParameters() {
        // Given
        let authString = "apikey=1234"
        let expected = "https://api.ingresse.com/test/?\(authString)"
        
        // When
        let request = try? builder
            .setPath("test/")
            .setKeys(apiKey: "1234")
            .build()
        let generated = request?.url?.absoluteString ?? ""
        // Then
        XCTAssertEqual(expected, generated)
    }

    func testGestHostUrlHmlSearch() {
        // Given
        let expected = "https://hml-event.ingresse.com/search/company/?"

        // When
        let request = try? builder
            .setHost(.search)
            .setEnvironment(.hml)
            .build()

        let generated = request?.url?.absoluteString ?? ""
        // Then
        XCTAssertEqual(generated, expected)
    }

    func testGestHostUrl() {
        // Given
        let selectedEnv = Environment.prod
        let selectedHost = Host.api
        let expected = "https://\(selectedEnv.rawValue)\(selectedHost.rawValue)?apikey=1234"

        // When
        let request = try? builder
            .setHost(selectedHost)
            .setEnvironment(selectedEnv)
            .build()
        let generated = request?.url?.absoluteString ?? ""
        // Then
        XCTAssertEqual(generated, expected)
    }

    func testEnvironmentInitWithProd() {
        // When
        let env = Environment(envType: "prod")

        // Then
        XCTAssertEqual(env, .prod)
    }

    func testEnvironmentInitWithHml() {
        // When
        let env = Environment(envType: "hml")

        // Then
        XCTAssertEqual(env, .hml)
    }

    func testEnvironmentInitWithTest() {
        // When
        let env = Environment(envType: "test")

        // Then
        XCTAssertEqual(env, .test)
    }

    func testEnvironmentInitWithStg() {
        // When
        let env = Environment(envType: "stg")

        // Then
        XCTAssertEqual(env, .stg)
    }

    func testEnvironmentInitWithUndefined() {
        // When
        let env = Environment(envType: "abcd")

        // Then
        XCTAssertEqual(env, .undefined)
    }
}
