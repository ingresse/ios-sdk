//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class BaseServiceTests: XCTestCase {
    
    func testInit() {
        // Given
        let client = IngresseClient(publicKey: "1234", privateKey: "5678")

        // When
        let service = BaseService(client)

        // Then
        XCTAssertEqual(service.client.publicKey, "1234")
        XCTAssertEqual(service.client.privateKey, "5678")
    }
}
