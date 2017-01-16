//
//  IngresseAPIBuilder.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 12/8/16.
//  Copyright © 2016 Gondek. All rights reserved.
//

import UIKit

public enum IngresseAPIError : Error {
    case errorWithCode(code: Int)
    case genericError
    case requestError
    case jsonParserError
}

public class IngresseAPIBuilder: NSObject {
    
    /**
     API Response parser
     - throws: IngresseAPIError
     
     - parameter response: Response of request
     - parameter error:    Error from response
     - parameter data:     Data bytes
     - parameter completionHandler: Callback block in case of success
     */
    public static func build(_ response:URLResponse?, data:Data?, error:Error?, completionHandler:(_ responseData:[String:Any])->()) throws {
        if (data == nil || response == nil) {
            throw IngresseAPIError.requestError
        }
        
        do {
            let objData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            
            guard let obj = objData as? [String:Any] else {
                throw IngresseAPIError.jsonParserError
            }
            
            if let responseString = obj["responseData"] as? String {
                if responseString.contains("[Ingresse Exception Error]") {
                    // API Error
                    guard let responseError = obj["responseError"] as? [String:Any] else {
                        // Could not get response error
                        throw IngresseAPIError.jsonParserError
                    }
                    
                    // Show alert with error code
                    let code = responseError["code"] as! Int
                    
                    throw IngresseAPIError.errorWithCode(code: code)
                }
            }
            
            guard let responseData = obj["responseData"] as? [String:Any] else {
                // Could not get response data
                
                guard let responseArray = obj["responseData"] as? [[String:Any]] else {
                    throw IngresseAPIError.jsonParserError
                }
                
                completionHandler(["data":responseArray])
                return
            }
            
            completionHandler(responseData)
        } catch {
            throw IngresseAPIError.jsonParserError
        }
    }
}
