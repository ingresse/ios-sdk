//
//  MockClient.swift
//  IngresseSDKTests
//
//  Created by Rubens Gondek on 6/8/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import IngresseSDK

class MockClient : RestClientInterface {
    
    var response : [String:Any]!

    func POST(
        url: String,
        parameters: [String : Any],
        onSuccess: @escaping ([String : Any]) -> (),
        onError: @escaping (APIError) -> ()) {
        onSuccess(response)
    }
    
    func GET(
        url: String,
        onSuccess: @escaping ([String : Any]) -> (),
        onError: @escaping (APIError) -> ()) {
        onSuccess(response)
    }
}
