//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class UserEventsDownloaderDelegateSpy: UserEventsDownloaderDelegate {
    // MARK: Configuration
    var resultData: [[String: Any]]?
    var syncError: APIError?
    var asyncExpectation: XCTestExpectation?

    // MARK: Method call expectations
    var didDownloadEventsCalled: Bool = false
    var didFailDownloadEventsCalled: Bool = false

    // MARK: Spied methods
    func didDownloadEvents(_ userEvents: [[String : Any]]) {
        didDownloadEventsCalled = true
        resultData = userEvents
        asyncExpectation?.fulfill()
    }

    func didFailDownloadEvents(errorData: APIError) {
        didFailDownloadEventsCalled = true
        syncError = errorData
        asyncExpectation?.fulfill()
    }
}
