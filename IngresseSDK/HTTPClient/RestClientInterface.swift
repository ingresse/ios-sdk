//
//  RestClientInterface.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/17/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

@objc public protocol RestClientInterface {
    
    func POST(url: String, parameters: [String:Any], onSuccess: @escaping (_ responseData:[String:Any]) -> Void, onError: @escaping (_ error: APIError) -> Void)
    func POSTData(url: String, data: Data, JSONData: Bool, onSuccess: @escaping (_ responseData:[String:Any]) -> Void, onError: @escaping (_ error: APIError) -> Void)
    func GET(url: String, onSuccess: @escaping (_ responseData:[String:Any]) -> Void, onError: @escaping (_ error: APIError) -> Void)
}
