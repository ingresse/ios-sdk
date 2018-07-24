//
//  Copyright © 2017 Ingresse. All rights reserved.
//

import IngresseSDK

class MockClient: RestClientInterface {
    // MARK: Configuration
    var error: APIError?
    var response: [String:Any]?
    var shouldFail: Bool = false

    // MARK: Mocked methods
    func POST(
        url: String,
        parameters: [String : Any],
        onSuccess: @escaping ([String : Any]) -> (),
        onError: @escaping (APIError) -> ()) {
        shouldFail ? onError(error!) : onSuccess(response!)
    }
    
    func GET(
        url: String,
        onSuccess: @escaping ([String : Any]) -> (),
        onError: @escaping (APIError) -> ()) {
        shouldFail ? onError(error!) : onSuccess(response!)
    }
}
