//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TicketSyncDelegateSpy: TicketSyncDelegate {
    // MARK: Configuration
    var resultData: [UserTicket]?
    var resultPage: PaginationInfo?
    var syncError: APIError?
    var asyncExpectation: XCTestExpectation?

    // MARK: Method call expectations
    var didSyncTicketsPageCalled: Bool = false
    var didFailSyncTicketsCalled: Bool = false

    // MARK: Spied methods
    func didSyncTicketsPage(tickets: [UserTicket], pagination: PaginationInfo) {
        didSyncTicketsPageCalled = true
        resultData = tickets
        resultPage = pagination
        asyncExpectation?.fulfill()
    }

    func didFailSyncTickets(errorData: APIError) {
        didFailSyncTicketsCalled = true
        syncError = errorData
        asyncExpectation?.fulfill()
    }
}
