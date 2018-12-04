//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TransactionTests: XCTestCase {

    func testDecode() {
        // Given
        var json = [String: Any]()
        json["id"] = "1234"
        json["status"] = "status"
        json["transactionId"] = "transactionId"
        json["operatorId"] = "operatorId"
        json["salesgroupId"] = 2
        json["app_id"] = 3
        json["salesgroupId"] = 2
        json["paymenttype"] = "paymenttype"
        json["paymentoption"] = "paymentoption"
        json["paymentdetails"] = "paymentdetails"
        json["totalPaid"] = 11.1
        json["sum_up"] = 22.2
        json["paymentTax"] = 33.3
        json["interest"] = 11
        json["taxToCostumer"] = 22
        json["installments"] = 10
        json["creationdate"] = "creationdate"
        json["modificationdate"] = "modificationdate"
        json["bankbillet_url"] = "bankbillet_url"
        json["token"] = "token"
        json["event"] = ["id": "1"]
        json["session"] = ["id": "2"]
        json["customer"] = ["id": 3]
        json["refund"] = ["operator": "4"]
        json["creditCard"] = [
            "firstDigits": "1111",
            "lastDigits": "9999"
        ]

        // When
        let obj = TransactionData.fromJSON(json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, "1234")
        XCTAssertEqual(obj?.status, "status")
        XCTAssertEqual(obj?.transactionId, "transactionId")
        XCTAssertEqual(obj?.operatorId, "operatorId")
        XCTAssertEqual(obj?.salesgroupId, 2)
        XCTAssertEqual(obj?.appId, 3)
        XCTAssertEqual(obj?.paymenttype, "paymenttype")
        XCTAssertEqual(obj?.paymentoption, "paymentoption")
        XCTAssertEqual(obj?.paymentdetails, "paymentdetails")
        XCTAssertEqual(obj?.totalPaid, 11.1)
        XCTAssertEqual(obj?.sumUp, 22.2)
        XCTAssertEqual(obj?.paymentTax, 33.3)
        XCTAssertEqual(obj?.interest, 11)
        XCTAssertEqual(obj?.taxToCostumer, 22)
        XCTAssertEqual(obj?.installments, 10)
        XCTAssertEqual(obj?.creationdate, "creationdate")
        XCTAssertEqual(obj?.modificationdate, "modificationdate")
        XCTAssertEqual(obj?.bankbilletUrl, "bankbillet_url")
        XCTAssertEqual(obj?.token, "token")
        XCTAssertEqual(obj?.event?.id, "1")
        XCTAssertEqual(obj?.session?.id, "2")
        XCTAssertEqual(obj?.customer?.id, 3)
        XCTAssertEqual(obj?.refund?.operatorId, "4")
        XCTAssertEqual(obj?.creditCard?.firstDigits, "1111")
        XCTAssertEqual(obj?.creditCard?.lastDigits, "9999")
        XCTAssertEqual(obj?.hasRefund, true)
    }

    func testBasketArray() {
        // Given
        var json = [String: Any]()
        json["basket"] = [
            ["id": 4],
            ["id": 5],
            ["id": 6]
        ]

        // When
        let obj = TransactionData.fromJSON(json)

        // Then
        XCTAssertEqual(obj?.basket?.tickets.count, 3)
        XCTAssertEqual(obj?.basket?.tickets[0].id, 4)
        XCTAssertEqual(obj?.basket?.tickets[1].id, 5)
        XCTAssertEqual(obj?.basket?.tickets[2].id, 6)
    }

    func testBasketTickets() {
        // Given
        var json = [String: Any]()
        json["basket"] = [
            "tickets": [
                ["id": 1],
                ["id": 2],
                ["id": 3]
            ]
        ]

        // When
        let obj = TransactionData.fromJSON(json)

        // Then
        XCTAssertEqual(obj?.basket?.tickets.count, 3)
        XCTAssertEqual(obj?.basket?.tickets[0].id, 1)
        XCTAssertEqual(obj?.basket?.tickets[1].id, 2)
        XCTAssertEqual(obj?.basket?.tickets[2].id, 3)
    }
}
