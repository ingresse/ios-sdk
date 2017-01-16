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
    
    var errors: IngresseErrorsSwift?
    var errorsDict: [String:String]!
    
    override func setUp() {
        super.setUp()
        
        errors = IngresseErrorsSwift()
        
        let bundle = Bundle(identifier: "com.ingresse.IngresseSDK")!
        guard let path = bundle.path(forResource: "IngresseErrors", ofType: "plist") else {
            return
        }
        
        guard let dict = NSDictionary(contentsOfFile: path) else {
            return
        }
        
        self.errorsDict = dict as! [String:String]
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
