//
//  APIError.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import UIKit

public class APIError: NSObject {
    public var code: Int!
    public var title: String!
    public var message: String!
    public var response: [[String: Any]]!
    
    public func getCode() -> Int {
        return code
    }
    
    override init() {
        self.code = 0
        self.title = ""
        self.message = ""
        self.response = [[:]]
    }
    
    static public func getDefaultError() -> APIError {
        let error = APIError.Builder()
            .setCode(0)
            .build()
        
        return error
    }
    
    class Builder: NSObject {
        private var error: APIError!
        
        override init() {
            error = APIError()
        }
        
        func setCode(_ code: Int) -> Builder {
            error.code = code
            error.title = NSLocalizedString("OPS", comment: "")
            error.message = SDKErrors().getErrorMessage(code: code)
            
            return self
        }
        
        func setTitle(_ title: String) -> Builder {
            error.title = title
            
            return self
        }
        
        func setMessage(_ message: String) -> Builder {
            error.message = message
            
            return self
        }
        
        func setResponse(_ response: [[String:Any]]) -> Builder {
            error.response = response
            
            return self
        }
        
        func build() -> APIError {
            return error
        }
    }
}
