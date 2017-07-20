//
//  IngresseErrorsTests.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/16/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import XCTest
import IngresseSDK

class IngresseErrorsTests: XCTestCase {
    
    var errors: SDKErrors?
    var errorsDict: [String:String]!
    
    override func setUp() {
        super.setUp()
        
        errors = SDKErrors()
        
        errorsDict = SDKErrors.getErrorDict()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDefaultError() {
        let generated = errors?.getErrorMessage(code: 0)
        let expected = errorsDict["default_no_code"]!
        
        XCTAssertEqual(generated, expected)
    }
    
}
