//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class EquatableTests: XCTestCase {
    
    // MARK: - Category
    func testCategoryEqual() {
        // Given
        let cat1 = IngresseSDK.Category(id: 99, name: "name", slug: "slug", isPublic: true)
        let cat2 = IngresseSDK.Category(id: 99, name: "name", slug: "slug", isPublic: true)

        // When
        let equal = cat1 == cat2

        // Then
        XCTAssert(equal)
    }
    
    func testCategoryNotEqual() {
        // Given
        let cat1 = IngresseSDK.Category(id: 99, name: "name1", slug: "slug", isPublic: true)
        let cat2 = IngresseSDK.Category(id: 99, name: "name2", slug: "slug", isPublic: true)

        // When
        let equal = cat1 == cat2

        // Then
        XCTAssertFalse(equal)
    }
    
    // MARK: - Highlight
    func testHighlightEqual() {
        // Given
        let event1 = Highlight(banner: "banner", target: "target")
        let event2 = Highlight(banner: "banner", target: "target")

        // When
        let equal = event1 == event2

        // Then
        XCTAssert(equal)
    }
    
    func testHighlightNotEqual() {
        // Given
        let event1 = Highlight(banner: "banner1", target: "target")
        let event2 = Highlight(banner: "banner2", target: "target")

        // When
        let equal = event1 == event2

        // Then
        XCTAssertFalse(equal)
    }
}
