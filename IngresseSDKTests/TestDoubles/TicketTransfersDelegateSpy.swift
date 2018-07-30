//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class TicketTransfersDelegateSpy: TicketTransfersDelegate {
    // MARK: Configuration
    var resultData: [PendingTransfer]?
    var resultPage: PaginationInfo?
    var syncError: APIError?
    var asyncExpectation: XCTestExpectation?

    // MARK: Method call expectations
    var didDownloadPendingTransfersCalled: Bool = false
    var didFailDownloadTransfersCalled: Bool = false

    // MARK: Spied methods
    func didDownloadPendingTransfers(_ transfers: [PendingTransfer], page: PaginationInfo) {
        didDownloadPendingTransfersCalled = true
        resultData = transfers
        resultPage = page
        asyncExpectation?.fulfill()
    }

    func didFailDownloadTransfers(errorData: APIError) {
        didFailDownloadTransfersCalled = true
        syncError = errorData
        asyncExpectation?.fulfill()
    }
}
