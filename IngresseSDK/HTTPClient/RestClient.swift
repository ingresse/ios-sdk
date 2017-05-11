//
//  RestClient.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/17/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import UIKit

public class RestClient: NSObject, RestClientInterface {
    
    /**
     REST GET Method using NSURLConnection
     
     - parameter url: Request path
     
     - parameter completion: Callback block in case of success
     */
    public func GET(url: String, completion:@escaping (_ success:Bool,_ responseData:[String:Any]) -> ()) {
        let request = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue()) { (response:URLResponse?, data:Data?, error:Error?) in
            DispatchQueue.main.async {
                if error != nil {
                    completion(false, ["requestError":error!])
                    return
                }
                
                do {
                    try ResponseParser.build(response, data: data, completion: { (responseData:[String : Any]) in
                        completion(true, responseData)
                    })
                } catch IngresseException.errorWithCode(let code) {
                    let message = IngresseErrorsSwift.shared.getErrorMessage(code: code)
                    completion(false, ["errorCode":code, "errorMessage":message])
                } catch let error {
                    let message = IngresseErrorsSwift.shared.getErrorMessage(code: 0)
                    completion(false, ["errorCode":0, "errorMessage":message, "error":error])
                }
            }
        }
    }
    
    /**
     REST POST Method using NSURLConnection
     
     - parameter url:        Request path
     - parameter parameters: Post body parameters
     
     - parameter completion: Callback block in case of success
     */
    public func POST(url: String, parameters: [String:String], completion:@escaping (_ success:Bool,_ responseData:[String:Any]) -> ()) {
        
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.httpMethod = "POST"
        
        let body = parameters.stringFromHttpParameters()
        
        request.httpBody = body.data(using: .utf8)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue()) { (response:URLResponse?, data:Data?, error:Error?) in
            DispatchQueue.main.async {
                if error != nil {
                    completion(false, ["requestError":error!])
                    return
                }
                
                do {
                    try ResponseParser.build(response, data: data, completion: { (responseData:[String:Any]) in
                        completion(true, responseData)
                    })
                } catch IngresseException.errorWithCode(let code) {
                    let message = IngresseErrorsSwift.shared.getErrorMessage(code: code)
                    completion(false, ["errorCode":code, "errorMessage":message])
                } catch let error {
                    let message = IngresseErrorsSwift.shared.getErrorMessage(code: 0)
                    completion(false, ["errorCode":0, "errorMessage":message, "error":error])
                }
            }
        }
    }
}
