//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class PaymentMethodTests: XCTestCase {

    func testDecode() {
        // Given
        let installment = [["quantity": 10,
                    "value": 10,
                    "total": 10,
                    "taxValue": 10,
                    "shippingCost": 10]] as [[String : Any]]

        let json = ["type": "paymentType",
                    "installments": installment] as [String : Any]

        // When
        let obj = JSONDecoder().decodeDict(of: PaymentMethod.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.paymentType, "paymentType")
        XCTAssertEqual(obj?.installments.first!.quantity, 10)
        XCTAssertEqual(obj?.installments.first!.value, 10)
        XCTAssertEqual(obj?.installments.first!.total, 10)
        XCTAssertEqual(obj?.installments.first!.taxValue, 10)
        XCTAssertEqual(obj?.installments.first!.shippingCost, 10)
    }
}
