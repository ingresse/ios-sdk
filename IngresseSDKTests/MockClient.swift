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
    
    func GET(url: String, completion: @escaping (Bool, [String : Any]) -> ()) {
        completion(true, response)
    }
    
    func POST(url: String, parameters: [String : String], completion: @escaping (Bool, [String : Any]) -> ()) {
        completion(true, response)
    }
}
