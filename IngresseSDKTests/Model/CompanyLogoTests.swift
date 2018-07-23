//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class CompanyLogoTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String:Any]()
        json["small"] = "smallPoster"
        json["medium"] = "mediumPoster"
        json["large"] = "largePoster"

        // When
        let obj = JSONDecoder().decodeDict(of: CompanyLogo.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.small, "smallPoster")
        XCTAssertEqual(obj?.medium, "mediumPoster")
        XCTAssertEqual(obj?.large, "largePoster")
    }
}
