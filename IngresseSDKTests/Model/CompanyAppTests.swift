//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class CompanyAppTests: XCTestCase {
    
    func testDecode() {
        // Given
        var json = [String:Any]()
        json["id"] = 1
        json["name"] = "name"
        json["publicKey"] = "publicKey"
        json["privateKey"] = "privateKey"

        // When
        let obj = JSONDecoder().decodeDict(of: CompanyApp.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, 1)
        XCTAssertEqual(obj?.name, "name")
        XCTAssertEqual(obj?.publicKey, "publicKey")
        XCTAssertEqual(obj?.privateKey, "privateKey")
    }
}
