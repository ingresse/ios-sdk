//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest

class URLSessionDataTaskMock: URLSessionDataTask {
    // MARK: Configuration
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    // MARK: Mocked Methods
    override func resume() {
        closure()
    }
}
