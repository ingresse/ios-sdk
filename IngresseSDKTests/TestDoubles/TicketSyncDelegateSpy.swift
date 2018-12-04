//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TicketSyncDelegateSpy: TicketSyncDelegate {
    // MARK: Configuration
    var resultData: [UserTicket]?
    var resultEventId: String?
    var resultPage: PaginationInfo?
    var syncError: APIError?
    var asyncExpectation: XCTestExpectation?

    // MARK: Method call expectations
    var didSyncTicketsPageCalled: Bool = false
    var didFailSyncTicketsCalled: Bool = false

    // MARK: Spied methods
    func didSyncTicketsPage(eventId: String, tickets: [UserTicket], pagination: PaginationInfo) {
        didSyncTicketsPageCalled = true
        resultData = tickets
        resultPage = pagination
        resultEventId = eventId
        asyncExpectation?.fulfill()
    }

    func didFailSyncTickets(errorData: APIError) {
        didFailSyncTicketsCalled = true
        syncError = errorData
        asyncExpectation?.fulfill()
    }
}
