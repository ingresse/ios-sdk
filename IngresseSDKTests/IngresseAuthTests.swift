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
    
    var restClient : MockClient!
    var client : IngresseClient!
    var service : IngresseService!
    
    override func setUp() {
        super.setUp()
        
        restClient = MockClient()
        client = IngresseClient(publicKey: "1234", privateKey: "2345", restClient: restClient)
        service = IngresseService(client: client)
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
        loginSuccessResponse["data"] = ["userId":12345,
                                        "token" :"12345-abcdefghijklmnopqrstuvxyz"]
        
        restClient.response = loginSuccessResponse
        
        var logged = false
        var responseError: APIError?
        
        service.auth.loginWithEmail("email@test.com", andPassword: "password", onSuccess: { (user) in
            logged = true
            loginExpectation.fulfill()
        }) { (error) in
            responseError = error
            logged = false
            loginExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 15) { (error:Error?) in
            XCTAssertTrue(logged, "\(responseError!.message)")
        }
    }
    
    func testLoginFailure() {
        let loginExpectation = expectation(description: "loginCallback")
        
        var loginFailResponse = [String:Any]()
        loginFailResponse["status"] = 0
        loginFailResponse["message"] = "Teste de falha"
        
        restClient.response = loginFailResponse
        
        var logged = true
        var responseError: APIError?
        
        service.auth.loginWithEmail("email@test.com", andPassword: "password", onSuccess: { (user) in
            logged = true
            loginExpectation.fulfill()
        }) { (error) in
            responseError = error
            logged = false
            loginExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error:Error?) in
            XCTAssertFalse(logged, "\(responseError!.message)")
        }
    }
}
