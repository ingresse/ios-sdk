//
//  RestClientInterface.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/17/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

@objc public protocol RestClientInterface {
    
    func POST(url: String, parameters: [String:String], onSuccess: @escaping (_ responseData:[String:Any]) -> (), onError: @escaping (_ error: APIError) -> ())
    func GET(url: String, onSuccess: @escaping (_ responseData:[String:Any]) -> (), onError: @escaping (_ error: APIError) -> ())
}
