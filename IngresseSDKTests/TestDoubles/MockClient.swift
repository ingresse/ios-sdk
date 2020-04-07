//
//  Copyright © 2017 Ingresse. All rights reserved.
//

import IngresseSDK

class MockClient: RestClientInterface {

    // MARK: Configuration
    var error: APIError?
    var response: [String: Any]?
    var shouldFail: Bool = false
    var requestCalled: URLRequest?

    // MARK: Mocked methods
    func POST(request: URLRequest,
              parameters: [String: Any],
              customHeader: [String: Any]?,
              onSuccess: @escaping ([String: Any]) -> Void,
              onError: @escaping ErrorHandler) {
        requestCalled = request
        shouldFail ? onError(error!) : onSuccess(response!)
    }
    
    func POSTData(request: URLRequest,
                  data: Data?,
                  customHeader: [String: Any]?,
                  JSONData: Bool,
                  onSuccess: @escaping ([String: Any]) -> Void,
                  onError: @escaping ErrorHandler) {
        requestCalled = request
        shouldFail ? onError(error!) : onSuccess(response!)
    }

    func GET(request: URLRequest,
             onSuccess: @escaping ([String: Any]) -> Void,
             onError: @escaping (APIError) -> Void) {
        requestCalled = request
        shouldFail ? onError(error!) : onSuccess(response!)
    }

    func PUT(request: URLRequest,
             parameters: [String: Any],
             onSuccess: @escaping ([String: Any]) -> Void,
             onError: @escaping ErrorHandler) {
        requestCalled = request
        shouldFail ? onError(error!) : onSuccess(response!)
    }

    func PUTData(request: URLRequest,
                 data: Data?,
                 JSONData: Bool,
                 onSuccess: @escaping ([String: Any]) -> Void,
                 onError: @escaping ErrorHandler) {
        requestCalled = request
        shouldFail ? onError(error!) : onSuccess(response!)
    }

    func DELETE(request: URLRequest,
                parameters: [String: Any],
                onSuccess: @escaping ([String: Any]) -> Void,
                onError: @escaping ErrorHandler) {
        requestCalled = request
        shouldFail ? onError(error!) : onSuccess(response!)
    }

    func DELETEData(request: URLRequest,
                    data: Data?,
                    JSONData: Bool,
                    onSuccess: @escaping ([String: Any]) -> Void,
                    onError: @escaping ErrorHandler) {
        requestCalled = request
        shouldFail ? onError(error!) : onSuccess(response!)
    }
}
