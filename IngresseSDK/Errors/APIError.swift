//
//  APIError.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import UIKit

public class APIError: NSObject {
    public var code: Int = 0
    public var title: String = ""
    public var message: String = ""
    public var category: String = ""
    public var error: String = ""
    public var response: [String: Any] = [:]
    
    public func getCode() -> Int {
        return code
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
            error.title = SDKErrors.shared.getErrorTitle(code: code)
            error.message = SDKErrors.shared.getErrorMessage(code: code)
            
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
        
        func setResponse(_ response: [String:Any]) -> Builder {
            error.response = response
            
            return self
        }
        
        func setError(_ errorMessage: String) -> Builder {
            error.error = errorMessage

            return self
        }

        func setCategory(_ category: String) -> Builder {
            error.category = category

            return self
        }

        func build() -> APIError {
            return error
        }
    }
}
