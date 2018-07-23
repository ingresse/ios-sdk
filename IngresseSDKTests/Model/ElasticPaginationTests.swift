//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class ElasticPaginationTests: XCTestCase {
    
    func testNextOffset() {
        // Given
        var pagination = ElasticPagination()
        pagination.size = 50
        pagination.total = 175
        pagination.currentOffset = 0

        // When
        let nextOffset = pagination.nextOffset

        // Then
        XCTAssertEqual(nextOffset, 50)
    }
    
    func testIsLastPage() {
        // Given
        var pagination = ElasticPagination()
        pagination.size = 50
        pagination.total = 175
        pagination.currentOffset = 150

        // When
        let lastPage = pagination.isLastPage

        // Then
        XCTAssertTrue(lastPage)
    }
    
    func testIsLastPageFalse() {
        // Given
        var pagination = ElasticPagination()
        pagination.size = 50
        pagination.total = 175
        pagination.currentOffset = 0

        // When
        let lastPage = pagination.isLastPage

        // Then
        XCTAssertFalse(lastPage)
    }
}
