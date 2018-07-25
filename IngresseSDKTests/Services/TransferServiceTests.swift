//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TransferServiceTests: XCTestCase {
    var restClient: MockClient!
    var client: IngresseClient!
    var service: TransfersService!
    
    override func setUp() {
        super.setUp()

        restClient = MockClient()
        client = IngresseClient(publicKey: "1234", privateKey: "2345", restClient: restClient)
        service = IngresseService(client: client).transfers
    }
    
    
}
