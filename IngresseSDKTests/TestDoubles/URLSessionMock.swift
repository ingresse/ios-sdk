//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest

class URLSessionMock: URLSession {
    // MARK: Configuration
    var data: Data?
    var response: URLResponse?
    var error: Error?

    // MARK: Mocked Methods
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let dataTask = URLSessionDataTaskMock {
            completionHandler(self.data, self.response, self.error)
        }

        return dataTask
    }
}
