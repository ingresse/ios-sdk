//
//  Service_AuthTests.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/16/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import XCTest
import IngresseSDK

class Service_AuthTests: XCTestCase {
    
    var service : IngresseService!
    
    override func setUp() {
        super.setUp()
        
        // Init service
        service = IngresseService(publicKey: "e9424e72263bcab5d37ecb04e05505cf91d67639", privateKey: "5e09cb45c8665fff9fd0d5e043d0152191943a31", host: .homolog);
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoginSuccess() {
        let loginExpectation = expectation(description: "loginCallback")
        
        var ingUser : IngresseUser?
        
        service.loginWithEmail("rubens.gondek@gmail.com", andPassword: "senha157") { (success:Bool, user:IngresseUser?) in
            ingUser = user
            loginExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 20) { (error:Error?) in
            XCTAssertNotNil(ingUser)
        }
    }
    
    func testLoginFailure() {
        let loginExpectation = expectation(description: "loginCallback")
        
        var ingUser : IngresseUser?
        
        service.loginWithEmail("rubens.gondek@gmail.com", andPassword: "senha158") { (success:Bool, user:IngresseUser?) in
            ingUser = user
            loginExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 20) { (error:Error?) in
            XCTAssertNil(ingUser)
        }
    }
}
