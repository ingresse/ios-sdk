//
//  Copyright © 2017 Ingresse. All rights reserved.
//

import IngresseSDK

class MockClient: RestClientInterface {

    // MARK: Configuration
    var error: APIError?
    var response: [String: Any]?
    var shouldFail: Bool = false
    var urlCalled: String?

    // MARK: Mocked methods
    func POST(url: String,
              parameters: [String: Any],
              customHeader: [String: Any]?,
              onSuccess: @escaping ([String: Any]) -> Void,
              onError: @escaping ErrorHandler) {
        urlCalled = url
        shouldFail ? onError(error!) : onSuccess(response!)
    }
    
    func POSTData(url: String,
                  data: Data?,
                  customHeader: [String: Any]?,
                  JSONData: Bool,
                  onSuccess: @escaping ([String: Any]) -> Void,
                  onError: @escaping ErrorHandler) {
        urlCalled = url
        shouldFail ? onError(error!) : onSuccess(response!)
    }

    func GET(
        url: String,
        onSuccess: @escaping ([String: Any]) -> Void,
        onError: @escaping (APIError) -> Void) {
        urlCalled = url
        shouldFail ? onError(error!) : onSuccess(response!)
    }

    func PUT(url: String,
             parameters: [String: Any],
             onSuccess: @escaping ([String: Any]) -> Void,
             onError: @escaping ErrorHandler) {
        urlCalled = url
        shouldFail ? onError(error!) : onSuccess(response!)
    }

    func PUTData(url: String,
                 data: Data?,
                 JSONData: Bool,
                 onSuccess: @escaping ([String: Any]) -> Void,
                 onError: @escaping ErrorHandler) {
        urlCalled = url
        shouldFail ? onError(error!) : onSuccess(response!)
    }

    func DELETE(url: String,
                parameters: [String: Any],
                onSuccess: @escaping ([String: Any]) -> Void,
                onError: @escaping ErrorHandler) {
        urlCalled = url
        shouldFail ? onError(error!) : onSuccess(response!)
    }

    func DELETEData(url: String,
                    data: Data?,
                    JSONData: Bool,
                    onSuccess: @escaping ([String: Any]) -> Void,
                    onError: @escaping ErrorHandler) {
        urlCalled = url
        shouldFail ? onError(error!) : onSuccess(response!)
    }
}
