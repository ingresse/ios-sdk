//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class CompanyDataTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String:Any]()
        json["userId"] = 99
        json["token"] = "token-99"
        json["authToken"] = "authToken-99"
        json["company"] = ["id":1]
        json["application"] = ["id":2]

        // When
        let obj = JSONDecoder().decodeDict(of: CompanyData.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.userId, 99)
        XCTAssertEqual(obj?.token, "token-99")
        XCTAssertEqual(obj?.authToken, "authToken-99")
        XCTAssertEqual(obj?.company?.id, 1)
        XCTAssertEqual(obj?.application?.id, 2)
    }
}
