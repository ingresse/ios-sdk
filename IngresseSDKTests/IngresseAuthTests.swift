//
//  IngresseAuthTests.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/16/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import XCTest
import IngresseSDK

class IngresseAuthTests: XCTestCase {
    
    var client : MockClient!
    var service : IngresseClient!
    
    class MockClient : RestClientInterface {
        
        var response : [String:Any]?
        
        func GET(url: String, completion: @escaping (Bool, [String : Any]?) -> ()) {
            completion(true, response)
        }
        
        func POST(url: String, parameters: [String : String], completion: @escaping (Bool, [String : Any]?) -> ()) {
            completion(true, response)
        }
    }
    
    override func setUp() {
        super.setUp()
        
        client = MockClient()
        service = IngresseClient(publicKey: "", privateKey: "", urlHost: "", client: client)
    }
    
    override func tearDown() {
        super.tearDown()
        
        // Set user nil
        IngresseUser.user = nil
    }
    
    func testLoginSuccess() {
        let loginExpectation = expectation(description: "loginCallback")
        
        var loginSuccessResponse = [String:Any]()
        loginSuccessResponse["status"] = true
        loginSuccessResponse["data"] = ["userId":"14771",
                                        "token" :"14771-aoindipahj23hrwe8no3qheq12or"]
        
        client.response = loginSuccessResponse
        
        var logged = false
        
        service.loginWithEmail("email@test.com", andPassword: "password") { (success:Bool, response:[String:Any]?) in
            logged = success
            loginExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssertTrue(logged)
        }
    }
    
    func testLoginFailure() {
        let loginExpectation = expectation(description: "loginCallback")
        
        var loginFailResponse = [String:Any]()
        loginFailResponse["status"] = 0
        
        client.response = loginFailResponse
        
        var logged = true
        
        service.loginWithEmail("email@test.com", andPassword: "password") { (success:Bool, response:[String:Any]?) in
            logged = success
            loginExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssertFalse(logged)
        }
    }
}
