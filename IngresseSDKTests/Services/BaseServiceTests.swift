//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class BaseServiceTests: XCTestCase {
    
    func testInit() {
        // Given
        let client = IngresseClient(apiKey: "1234", userAgent: "")

        // When
        let service = BaseService(client)

        // Then
        XCTAssertEqual(service.client.apiKey, "1234")
    }
}
