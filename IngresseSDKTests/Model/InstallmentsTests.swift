//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class InstallmentsTests: XCTestCase {

    func testDecode() {
        // Given
        let json = ["quantity": 10,
                    "value": 10,
                    "total": 10,
                    "taxValue": 10,
                    "shippingCost": 10] as [String: Any]

        // When
        let obj = JSONDecoder().decodeDict(of: Installment.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.quantity, 10)
        XCTAssertEqual(obj?.value, 10)
        XCTAssertEqual(obj?.total, 10)
        XCTAssertEqual(obj?.taxValue, 10)
        XCTAssertEqual(obj?.shippingCost, 10)
    }
}
