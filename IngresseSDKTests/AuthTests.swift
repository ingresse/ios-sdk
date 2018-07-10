//
//  IngresseAuthTests.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/16/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import XCTest
import IngresseSDK

class AuthTests: XCTestCase {

    var restClient : MockClient!
    var client : IngresseClient!
    var service : IngresseService!

    override func setUp() {
        super.setUp()

        restClient = MockClient()
        //pegar chaves que estão no app
        client = IngresseClient(publicKey: "e9424e72263bcab5d37ecb04e05505cf91d67639", privateKey: "5e09cb45c8665fff9fd0d5e043d0152191943a31", urlHost: "https://test-api.ingresse.com/")
        //restclient = null

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

    func testLogout() {
        var data = [String:Any]()
        data["userId"] = 1234
        data["token"] = "test token"

        IngresseUser.login(loginData: data)

        XCTAssertNotNil(IngresseUser.user)

        IngresseUser.logout()

        XCTAssertNil(IngresseUser.user)
    }

    func testFillDataUserNil() {
        IngresseUser.logout()

        IngresseUser.fillData(userData: [String:Any]())

        XCTAssertNil(IngresseUser.user)
    }
}
