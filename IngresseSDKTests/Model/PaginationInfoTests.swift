//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class PaginationInfoTests: XCTestCase {

    func testDecoder() {
        // Given
        var json = [String: Any]()
        json["currentPage"] = 3
        json["lastPage"] = 5
        json["totalResults"] = 500
        json["pageSize"] = 100

        // When
        let obj = JSONDecoder().decodeDict(of: PaginationInfo.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.lastPage, 5)
        XCTAssertEqual(obj?.pageSize, 100)
        XCTAssertEqual(obj?.currentPage, 3)
        XCTAssertEqual(obj?.totalResults, 500)
    }

    func testNextPage() {
        // Given
        let obj = PaginationInfo()

        // When
        XCTAssertEqual(obj.currentPage, 0)

        // Then
        XCTAssertEqual(obj.nextPage, 1)
    }
    
    func testIsLastPage() {
        // Given
        let obj = PaginationInfo()

        // When
        XCTAssertEqual(obj.currentPage, 0)
        XCTAssertEqual(obj.lastPage, 0)

        // Then
        XCTAssert(obj.isLastPage)
    }
}
