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

    func testDecoder() {
        var json = [String:Any]()
        json["currentPage"] = 3
        json["lastPage"] = 5
        json["totalResults"] = 500
        json["pageSize"] = 100

        guard let obj = JSONDecoder().decodeDict(of: PaginationInfo.self, from: json) else {
            XCTFail("Could not convert object")
            return
        }

        XCTAssertEqual(obj.lastPage, 5)
        XCTAssertEqual(obj.pageSize, 100)
        XCTAssertEqual(obj.currentPage, 3)
        XCTAssertEqual(obj.totalResults, 500)
    }

    func testNextPage() {
        let obj = PaginationInfo()

        XCTAssertEqual(obj.currentPage, 0)
        XCTAssertEqual(obj.nextPage, 1)
    }
    
}
