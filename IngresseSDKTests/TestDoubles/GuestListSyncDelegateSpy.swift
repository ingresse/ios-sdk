//
//  Copyright © 2017 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class GuestListSyncDelegateSpy: GuestListSyncDelegate {
    // MARK: Configuration
    var guestListSyncResult: [GuestTicket]? = .none
    var syncFailError: APIError?
    var asyncExpectation: XCTestExpectation?
    
    // MARK: Method call expectations
    var didSyncGuestsPageCalled: Bool = false
    var didFailSyncGuestListCalled: Bool = false

    // MARK: Spied methods
    func didSyncGuestsPage(_ page: PaginationInfo, _ guests: [GuestTicket]) {
        didSyncGuestsPageCalled = true
        guestListSyncResult = guests
        asyncExpectation!.fulfill()
    }
    
    func didFailSyncGuestList(errorData: APIError) {
        didFailSyncGuestListCalled = true
        syncFailError = errorData
        asyncExpectation!.fulfill()
    }
}
