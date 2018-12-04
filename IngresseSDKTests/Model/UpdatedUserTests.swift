//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class UpdatedUserTests: XCTestCase {
    
    func testDecode() {
        // Given
        let json = ["ddi": "ddi",
                    "phone": "phone",
                    "id": "id",
                    "lastname": "lastname",
                    "verified": true,
                    "email": "email",
                    "cpf": "cpf",
                    "name": "name"] as [String: Any]

        // When
        let obj = JSONDecoder().decodeDict(of: UpdatedUser.self, from: json)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.ddi, "ddi")
        XCTAssertEqual(obj?.phone, "phone")
        XCTAssertEqual(obj?.id, "id")
        XCTAssertEqual(obj?.lastname, "lastname")
        XCTAssertEqual(obj?.verified, true)
        XCTAssertEqual(obj?.email, "email")
        XCTAssertEqual(obj?.cpf, "cpf")
        XCTAssertEqual(obj?.name, "name")
    }
    
    func testEmptyInit() {
        // When
        let obj = UpdatedUser()

        // Then
        XCTAssertEqual(obj.ddi, "")
        XCTAssertEqual(obj.phone, "")
        XCTAssertEqual(obj.id, "")
        XCTAssertEqual(obj.lastname, "")
        XCTAssertEqual(obj.verified, false)
        XCTAssertEqual(obj.email, "")
        XCTAssertEqual(obj.cpf, "")
        XCTAssertEqual(obj.name, "")
    }
}
