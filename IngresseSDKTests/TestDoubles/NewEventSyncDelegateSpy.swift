//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class NewEventSyncDelegateSpy: NewEventSyncDelegate {
    // MARK: Configuration
    var resultData: [NewEvent]?
    var resultPage: ElasticPagination?
    var syncError: APIError?
    var asyncExpectation: XCTestExpectation?

    // MARK: Method call expectations
    var didSyncEventsCalled: Bool = false
    var didFailCalled: Bool = false

    // MARK: Spied methods
    func didSyncEvents(_ events: [NewEvent], page: ElasticPagination) {
        didSyncEventsCalled = true
        resultData = events
        resultPage = page
        asyncExpectation?.fulfill()
    }

    func didFail(error: APIError) {
        didFailCalled = true
        syncError = error
        asyncExpectation?.fulfill()
    }
}
