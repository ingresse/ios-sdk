//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class PaymentResponseTests: XCTestCase {

    func testDecode() {
        // Given
        var json = [String:Any]()
        json["boleto"] = "boleto"
        json["message"] = "message"
        json["status"] = "status"
        json["tax"] = 0.0
        json["total"] = 0.0
        json["transactionId"] = "transactionId"

        // When
        let obj = JSONDecoder().decodeDict(of: PaymentResponse.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.boleto, "boleto")
        XCTAssertEqual(obj?.message, "message")
        XCTAssertEqual(obj?.status, "status")
        XCTAssertEqual(obj?.tax, 0.0)
        XCTAssertEqual(obj?.total, 0.0)
        XCTAssertEqual(obj?.transactionId, "transactionId")
    }

    func testFromJSON() {
        var json = [String:Any]()
        json["boleto"] = "boleto"
        json["message"] = "message"
        json["status"] = "status"
        json["tax"] = 0.0
        json["total"] = 0.0
        json["transactionId"] = "transactionId"

        // When
        let obj = PaymentResponse.fromJSON(json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.boleto, "boleto")
        XCTAssertEqual(obj?.message, "message")
        XCTAssertEqual(obj?.status, "status")
        XCTAssertEqual(obj?.tax, 0.0)
        XCTAssertEqual(obj?.total, 0.0)
        XCTAssertEqual(obj?.transactionId, "transactionId")
    }

    func testInit() {
        // When
        let obj = PaymentResponse()

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj.boleto, "")
        XCTAssertEqual(obj.message, "")
        XCTAssertEqual(obj.status, "")
        XCTAssertEqual(obj.tax, 0)
        XCTAssertEqual(obj.total, 0)
        XCTAssertEqual(obj.transactionId, "")
    }
}
