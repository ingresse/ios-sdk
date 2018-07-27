//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class CheckinSyncDelegateSpy: CheckinSyncDelegate {
    // MARK: Configuration
    var checkinResult: [CheckinTicket]?
    var syncFailError: APIError?
    var asyncExpectation: XCTestExpectation?

    // MARK: Method call expectations
    var didCheckinTicketsCalled: Bool = false
    var didFailCheckinCalled: Bool = false

    // MARK: Spied methods
    func didCheckinTickets(_ tickets: [CheckinTicket]) {
        didCheckinTicketsCalled = true
        checkinResult = tickets
        asyncExpectation?.fulfill()
    }

    func didFailCheckin(errorData: APIError) {
        didFailCheckinCalled = true
        syncFailError = errorData
        asyncExpectation?.fulfill()
    }
}
