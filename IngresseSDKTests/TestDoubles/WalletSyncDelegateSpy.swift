//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class WalletSyncDelegateSpy: WalletSyncDelegate {
    // MARK: Configuration
    var resultData: [WalletItem]?
    var resultPage: PaginationInfo?
    var resultUserId: String?
    var syncError: APIError?
    var asyncExpectation: XCTestExpectation?

    // MARK: Method call expectations
    var didSyncItemsPageCalled: Bool = false
    var didFailSyncItemsCalled: Bool = false

    // MARK: Spied methods
    func didSyncItemsPage(_ items: [WalletItem], from: String, pagination: PaginationInfo) {
        didSyncItemsPageCalled = true
        resultData = items
        resultPage = pagination
        resultUserId = from
        asyncExpectation?.fulfill()
    }

    func didFailSyncItems(errorData: APIError) {
        didFailSyncItemsCalled = true
        syncError = errorData
        asyncExpectation?.fulfill()
    }
}
