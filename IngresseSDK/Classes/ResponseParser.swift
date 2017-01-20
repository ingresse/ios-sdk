//
//  IngresseAPIBuilder.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 12/8/16.
//  Copyright © 2016 Gondek. All rights reserved.
//

import UIKit

public enum IngresseException : Error {
    case errorWithCode(code: Int)
    case genericError
    case requestError
    case jsonParserError
}

public class ResponseParser: NSObject {
    
    /**
     API Response parser
     - throws: IngresseException
     
     - parameter response: Response of request
     - parameter data:     Data bytes
     - parameter completion: Callback block in case of success
     */
    public static func build(_ response:URLResponse?, data:Data?, completion:(_ responseData:[String:Any])->()) throws {
        if (data == nil || response == nil) {
            throw IngresseException.requestError
        }
        
        do {
            let objData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            
            guard let obj = objData as? [String:Any] else {
                throw IngresseException.jsonParserError
            }
            
            if let responseString = obj["responseData"] as? String {
                if responseString.contains("[Ingresse Exception Error]") {
                    // API Error
                    guard let responseError = obj["responseError"] as? [String:Any] else {
                        // Could not get response error
                        throw IngresseException.jsonParserError
                    }
                
                    // Get error code
                    let code = responseError["code"] as! Int
                    
                    throw IngresseException.errorWithCode(code: code)
                }
            }
            
            guard let responseData = obj["responseData"] as? [String:Any] else {
                // Could not get response data
                
                guard let responseArray = obj["responseData"] as? [[String:Any]] else {
                    throw IngresseException.jsonParserError
                }
                
                completion(["data":responseArray])
                return
            }
            
            completion(responseData)
        } catch {
            throw IngresseException.jsonParserError
        }
    }
}
