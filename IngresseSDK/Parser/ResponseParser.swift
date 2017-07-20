//
//  IngresseAPIBuilder.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2016 Gondek. All rights reserved.
//

public enum IngresseException: Error {
    case errorWithCode(code: Int)
    case genericError
    case requestError
    case jsonParserError
}

public class ResponseParser: NSObject {

    /// API Response parser
    ///
    /// - Parameters:
    ///   - response: Response of request
    ///   - data: byte representation of data
    ///   - completion: callback block
    /// - Throws: IngresseException
    public static func build(_ response: URLResponse?, data: Data?, completion: (_ responseData: [String: Any])->Void) throws {
        if data == nil || response == nil {
            throw IngresseException.requestError
        }

        var objData: Any

        do {
            objData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        } catch {
            throw IngresseException.jsonParserError
        }
        
        guard let obj = objData as? [String:Any] else {
            throw IngresseException.jsonParserError
        }
        
        if let responseString = obj["responseData"] as? String {
            if responseString.contains("[Ingresse Exception Error]") {
                // API Error
                guard
                    let responseError = obj["responseError"] as? [String:Any],
                    let code = responseError["code"] as? Int
                    else { throw IngresseException.jsonParserError }
                
                throw IngresseException.errorWithCode(code: code)
            }
        }

        guard let responseData = obj["responseData"] as? [String:Any] else {
            // Could not get response data

            guard let responseArray = obj["responseData"] as? [[String:Any]] else {
                throw IngresseException.jsonParserError
            }
            
            completion(["data": responseArray])
            return
        }

        completion(responseData)

    }
}
