//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class JSONDecoderTests: XCTestCase {

    struct TestObj: Codable {
        var id = 0
        var price = 0.0
        var hidden = false
        var enabled = false
        var name = ""
        var array = [String]()

        public init(from decoder: Decoder) throws {
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

            id = container.decodeKey(.id, ofType: Int.self)
            price = container.decodeKey(.price, ofType: Double.self)
            hidden = container.decodeKey(.hidden, ofType: Bool.self)
            enabled = container.decodeKey(.enabled, ofType: Bool.self)
            name = container.decodeKey(.name, ofType: String.self)
            array = container.decodeKey(.array, ofType: [String].self)
        }
    }

    func testDecodeDict() {
        // Given
        let dict: [String: Any] = [
            "id": 1,
            "price": 10.0,
            "hidden": true,
            "enabled": true,
            "name": "name",
            "array": ["object"]]

        // When
        let obj = JSONDecoder().decodeDict(of: TestObj.self, from: dict)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, 1)
        XCTAssertEqual(obj?.price, 10.0)
        XCTAssertEqual(obj?.hidden, true)
        XCTAssertEqual(obj?.enabled, true)
        XCTAssertEqual(obj?.name, "name")
        XCTAssertEqual(obj?.array.first, "object")
    }

    func testDecodeStringValues() {
        // Given
        let dict: [String: Any] = [
            "id": "1",
            "price": "10.0",
            "hidden": "true",
            "enabled": "1",
            "name": "name",
            "array": "[object]"]

        // When
        let obj = JSONDecoder().decodeDict(of: TestObj.self, from: dict)

        // Then
        XCTAssertNotNil(obj)
        XCTAssertEqual(obj?.id, 1)
        XCTAssertEqual(obj?.price, 10.0)
        XCTAssertEqual(obj?.hidden, true)
        XCTAssertEqual(obj?.enabled, true)
        XCTAssertEqual(obj?.name, "name")
        XCTAssertEqual(obj?.array, [])
    }
}
