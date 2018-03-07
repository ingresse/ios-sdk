//
//  PaginationInfoTests.swift
//  IngresseSDKTests
//
//  Created by Rubens Gondek on 2/16/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class PaginationInfoTests: XCTestCase {
    
    func testNextPage() {
        let obj = PaginationInfo()

        XCTAssertEqual(obj.currentPage, 0)
        XCTAssertEqual(obj.nextPage, 1)
    }
    
}
